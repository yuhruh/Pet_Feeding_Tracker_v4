# A one-time code that brings a Google, LINE or GitHub sign-in done in Chrome
# into the Android app (checkpoint I2): who signed in (nobody for a refusal),
# where to land and the message to show. Valid for 2 minutes, usable once, and
# only its digest is stored.
#
# The code alone signs nobody in: it only works in the WebView session that
# started the sign-in. That session keeps a secret; its digest (the challenge)
# travels to Chrome inside the signed context and is stored with the code. So a
# code put in a link for someone else to open is useless. And Chrome hands the
# code only to the Pet Tracker app (app_url), so another app on the phone that
# starts a sign-in with its own context never receives the code.
class NativeSignIn < ApplicationRecord
  LIFETIME = 2.minutes
  # Carried to Chrome: the app's language and the challenge. Invitation and
  # viewer-link tokens stay in the app's session (the context is only signed,
  # so anything in it can be read from the address and the request log).
  CONTEXT_LIFETIME = 10.minutes
  CONTEXT_KEYS = %w[locale challenge].freeze
  SECRET_KEY = :native_sign_in_secret

  belongs_to :user, optional: true

  def self.digest(code) = OpenSSL::Digest::SHA256.hexdigest(code.to_s)

  # The Android app (as in public/.well-known/assetlinks.json).
  APP_PACKAGE = "com.pettracker.v4".freeze

  # Where Chrome hands the code back. Not a bare pettracker:// link, which any
  # app on the phone can register for: an intent link naming the package, which
  # Android gives only to the installed Pet Tracker app (package names are
  # unique on a phone). Without the app, Chrome opens fallback_url instead.
  # The app (1.0.7 and later) reads it as pettracker://sign-in?code=…
  def self.app_url(code, fallback_url:)
    "intent://sign-in?code=#{CGI.escape(code.to_s)}#Intent;scheme=pettracker;package=#{APP_PACKAGE};" \
      "S.browser_fallback_url=#{CGI.escape(fallback_url)};end"
  end

  # Returns the code to hand to the app.
  def self.issue!(user:, path:, challenge:, flash: {}, data: {})
    where(expires_at: ...1.day.ago).delete_all
    code = SecureRandom.urlsafe_base64(32)
    create!(token_digest: digest(code), user: user, path: path, flash: flash.to_h.compact,
            data: data.to_h.merge("challenge" => challenge).compact, expires_at: LIFETIME.from_now)
    code
  end

  # The sign-in for this code, once, in the session that started it; nil when
  # unknown, used, expired or asked for by any other session.
  def self.redeem(code, session)
    secret = session[SECRET_KEY]
    return if code.blank? || secret.blank?

    record = find_by(token_digest: digest(code))
    return unless record && record.expires_at.future?
    return unless ActiveSupport::SecurityUtils.secure_compare(record.data["challenge"].to_s, digest(secret))
    # Only one request can mark it used.
    return unless where(id: record.id, used_at: nil).update_all(used_at: Time.current) == 1

    record
  end

  # A signed, short-lived context for the app's sign-in: its language and the
  # challenge for this session's secret (made on first use).
  def self.context_for(session, locale:)
    session[SECRET_KEY] ||= SecureRandom.urlsafe_base64(32)
    values = { "locale" => locale.to_s, "challenge" => digest(session[SECRET_KEY]) }.compact_blank
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
