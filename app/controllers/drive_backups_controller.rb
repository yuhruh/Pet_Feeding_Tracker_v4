# Connects the owner's Google Drive and manages their daily backup to it (see
# DriveBackup). Google refuses sign-in inside the Android app's WebView, so the
# profile page there points to the website for connecting.
class DriveBackupsController < ApplicationController
  before_action :require_own_cats
  before_action :set_backup, only: %i[update run destroy]
  rate_limit to: 5, within: 10.minutes, only: :run, by: -> { Current.user.id },
             with: -> { redirect_to users_path(anchor: "drive-backup"), alert: t("drive_backups.run.alert_rate_limit"), status: :see_other }

  # Off to Google's consent screen. The state ties Google's answer to this browser,
  # so nobody can attach their own Drive to someone else's account.
  def connect
    state = SecureRandom.urlsafe_base64(32)
    session[:drive_backup_connect] = { "state" => state, "locale" => I18n.locale.to_s }
    redirect_to GoogleDriveClient.authorize_url(redirect_uri: callback_url, state: state), allow_other_host: true
  end

  # Google sends the user back here, in the language they started in.
  def callback
    pending = session.delete(:drive_backup_connect)
    locale = pending.is_a?(Hash) && pending["locale"].presence_in(I18n.available_locales.map(&:to_s))
    I18n.with_locale(locale || I18n.locale) do
      redirect_to users_path(anchor: "drive-backup"), finish_connect(pending)
    end
  end

  def update
    if @backup.update(params.expect(drive_backup: [ :backup_hour ]))
      redirect_to users_path(anchor: "drive-backup"), notice: t(".notice", time: format("%02d:00", @backup.backup_hour)), status: :see_other
    else
      redirect_to users_path(anchor: "drive-backup"), alert: t(".alert"), status: :see_other
    end
  end

  def run
    return redirect_to(users_path(anchor: "drive-backup"), alert: t("drive_backups.not_connected"), status: :see_other) unless @backup.connected?

    DriveBackupUploadJob.perform_later(@backup)
    redirect_to users_path(anchor: "drive-backup"), notice: t(".notice"), status: :see_other
  end

  # Files already in Drive stay there: they're the user's.
  def destroy
    GoogleDriveClient.revoke(@backup.refresh_token) if @backup.connected?
    @backup.destroy!
    redirect_to users_path(anchor: "drive-backup"), notice: t(".notice"), status: :see_other
  end

  private

  def require_own_cats
    redirect_to users_path, alert: t("drive_backups.owner_only"), status: :see_other unless Current.user.owned_household
  end

  def set_backup
    @backup = Current.user.drive_backup or redirect_to users_path(anchor: "drive-backup"), alert: t("drive_backups.not_connected"), status: :see_other
  end

  # The address registered with Google, so never with a language in it.
  def callback_url = drive_backup_callback_url(locale: nil)

  # The flash to show: connected, or why not.
  def finish_connect(pending)
    state = pending.is_a?(Hash) ? pending["state"].to_s : ""
    return { alert: t("drive_backups.callback.failed") } unless state.present? && ActiveSupport::SecurityUtils.secure_compare(state, params[:state].to_s)
    return { alert: t("drive_backups.callback.cancelled") } if params[:error].present?

    token = GoogleDriveClient.exchange_code(params[:code].to_s, redirect_uri: callback_url)
    backup = Current.user.drive_backup || Current.user.build_drive_backup
    backup.update!(refresh_token: token, google_email: GoogleDriveClient.new(token).email, last_error: nil)
    DriveBackupUploadJob.perform_later(backup)
    { notice: t("drive_backups.callback.connected", email: backup.google_email) }
  rescue GoogleDriveClient::Error => error
    Rails.logger.error("[DriveBackup] connecting failed for user #{Current.user.id}: #{error.message}")
    { alert: t(error.message == "drive_permission_missing" ? "drive_backups.callback.permission_missing" : "drive_backups.callback.failed") }
  end
end
