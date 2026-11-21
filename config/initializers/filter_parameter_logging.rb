# Be sure to restart your server when you modify this file.

# Configure parameters to be partially matched (e.g. passw matches password) and filtered from the log file.
# Use this to limit dissemination of sensitive information.
# See the ActiveSupport::ParameterFilter documentation for supported notations and behaviors.
Rails.application.config.filter_parameters += [
  :passw, :email, :secret, :token, :_key, :crypt, :salt, :certificate, :otp, :ssn, :cvv, :cvc,
  # One-time codes (the Android app's sign-in, Google's and the providers' callbacks) and their state.
  /\Acode\z/, /\Astate\z/
]

# Secret links carry their token in the path, which parameter filtering doesn't
# reach: viewer links, invitations, share links and password resets. This masks
# the token in the "Started GET …" line and wherever else the request's path is
# logged or reported, and in "Redirected to …".
module FilteredSecretPaths
  PATTERN = %r{(/(?:view|join|shared|passwords)/)(?!new(?:[/?.]|\z))[^/?]+}

  def self.mask(path) = path.to_s.sub(PATTERN) { "#{$1}[FILTERED]" }

  def filtered_path = FilteredSecretPaths.mask(super)
end

ActiveSupport.on_load(:action_dispatch_request) { prepend FilteredSecretPaths }
Rails.application.config.filter_redirect << FilteredSecretPaths::PATTERN
