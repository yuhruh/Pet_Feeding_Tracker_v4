# Be sure to restart your server when you modify this file.

# Content-Security-Policy: the browser only runs scripts from the sources listed
# here, plus inline scripts carrying this request's nonce. Inline event handlers
# (onclick= etc.) are blocked, so use Stimulus actions instead.
# See https://guides.rubyonrails.org/security.html#content-security-policy-header
# test/system/content_security_policy_test.rb loads the main pages in Chrome and
# fails on any violation, so run it after adding a script, style or third-party host.

Rails.application.configure do
  config.content_security_policy do |policy|
    policy.default_src :self
    # importmap pins: big.js (ga.jspm.io) and i18n-js (esm.sh); Google Charts loader (www.gstatic.com).
    policy.script_src  :self, "https://ga.jspm.io", "https://esm.sh", "https://www.gstatic.com"
    # Inline style attributes are used throughout the views, so inline styles stay allowed.
    # Scripts are the main injection risk and get no such exception.
    policy.style_src   :self, :unsafe_inline, "https://fonts.googleapis.com", "https://www.gstatic.com"
    policy.font_src    :self, :data, "https://fonts.gstatic.com"
    policy.img_src     :self, :data, :blob, :https
    policy.connect_src :self
    policy.object_src  :none
    policy.base_uri    :self
    policy.frame_ancestors :self
    # form-action is deliberately unset: the Google, LINE and GitHub sign-in forms
    # POST here and are then redirected to the provider, which form-action would block.
  end

  # One random nonce per session, so inline scripts that Turbo Drive brings in on
  # later pages still match the policy of the page that was loaded first. Stored in
  # the session rather than using the session id, which is blank on a first visit.
  config.content_security_policy_nonce_generator = ->(request) { request.session[:csp_nonce] ||= SecureRandom.base64(16) }
  # Scripts only: a nonce in style-src would make browsers ignore 'unsafe-inline'.
  config.content_security_policy_nonce_directives = %w[script-src]
end
