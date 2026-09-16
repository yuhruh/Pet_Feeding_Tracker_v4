# Makes :gmail_api available as an ActionMailer delivery method. It sends over HTTPS,
# so it keeps working on hosts that block SMTP ports, and mail really comes from the
# Gmail account, so it passes Gmail's authenticity checks instead of landing in spam.
#
# config/environments/production.rb switches to it once a refresh token is configured;
# run `bin/rails gmail:refresh_token` once to obtain one.
#
# to_prepare (rather than an on_load hook) keeps the delivery class out of the boot
# sequence, so it isn't autoloaded while the app is still initializing.
Rails.application.config.to_prepare do
  ActionMailer::Base.add_delivery_method :gmail_api, GmailApiDelivery
end
