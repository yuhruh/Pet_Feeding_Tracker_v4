# A Google, LINE or GitHub account that signs in to this user.
class ConnectedService < ApplicationRecord
  PROVIDERS = %w[google_oauth2 line github].freeze

  belongs_to :user

  # "Google", "LINE" or "GitHub".
  def self.provider_name(provider) = I18n.t("native_sign_ins.start.providers.#{provider}", default: provider.to_s.humanize)
end
