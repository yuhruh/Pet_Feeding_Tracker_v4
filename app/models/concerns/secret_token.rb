# A long random token that is shown once (in a link) and stored only as a
# SHA-256 digest, so a copy of the database can't be turned into working links.
module SecretToken
  extend ActiveSupport::Concern

  # The plain token, available only on the record that just created it.
  attr_reader :token

  included do
    before_validation :generate_token, on: :create
  end

  class_methods do
    def digest(token)
      Digest::SHA256.hexdigest(token.to_s)
    end

    def find_by_token(token)
      find_by(token_digest: digest(token)) if token.present?
    end
  end

  private

  def generate_token
    @token = SecureRandom.urlsafe_base64(32)
    self.token_digest = self.class.digest(@token)
  end
end
