# A one-time code that brings a Google, LINE or GitHub sign-in done in Chrome
# into the Android app (checkpoint I2): who signed in (nobody for a refusal),
# where to land and the message to show. Valid for 2 minutes, usable once, and
# only its digest is stored.
class NativeSignIn < ApplicationRecord
  LIFETIME = 2.minutes
  # What the app's session was holding when sign-in started, carried to Chrome.
  CONTEXT_LIFETIME = 10.minutes
  CONTEXT_KEYS = %w[invitation_token viewer_link_token locale].freeze

  belongs_to :user, optional: true

  def self.digest(code) = OpenSSL::Digest::SHA256.hexdigest(code.to_s)

  # Returns the code to hand to the app.
  def self.issue!(user:, path:, flash: {}, data: {})
    where(expires_at: ...1.day.ago).delete_all
    code = SecureRandom.urlsafe_base64(32)
    create!(token_digest: digest(code), user: user, path: path, flash: flash.to_h.compact, data: data.to_h.compact, expires_at: LIFETIME.from_now)
    code
  end

  # The sign-in for this code, once; nil when unknown, used or expired.
  def self.redeem(code)
    return if code.blank?

    record = find_by(token_digest: digest(code))
    return unless record && record.expires_at.future?
    # Only one request can mark it used.
    return unless where(id: record.id, used_at: nil).update_all(used_at: Time.current) == 1

    record
  end

  # A signed, short-lived copy of the session values the sign-in should keep.
  def self.context_for(session, locale:)
    values = { "invitation_token" => session[:invitation_token], "viewer_link_token" => session[:viewer_link_token], "locale" => locale.to_s }.compact_blank
    verifier.generate(values, expires_in: CONTEXT_LIFETIME)
  end

  def self.read_context(signed)
    (verifier.verified(signed.to_s) || {}).slice(*CONTEXT_KEYS)
  rescue ActiveSupport::MessageVerifier::InvalidSignature, ArgumentError
    {}
  end

  def self.verifier = Rails.application.message_verifier(:native_sign_in_context)

  # Only a page of this site.
  def safe_path = path.to_s.start_with?("/") && !path.start_with?("//") ? path : "/"
end
