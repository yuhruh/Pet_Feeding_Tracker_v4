module NativeSignInHelper
  # A Google, LINE or GitHub button. On the website, a form posting to
  # /auth/:provider with the browser's time zone. In the Android app, a link the
  # app opens in a Chrome Custom Tab, where the whole sign-in happens; it carries
  # the invitation or viewer link this session holds (checkpoint I2).
  def provider_sign_in_button(provider, button_class:, &block)
    if hotwire_native_app?
      link_to native_sign_in_path(provider: provider, context: NativeSignIn.context_for(session, locale: I18n.locale)), class: button_class, &block
    else
      form_with url: "/auth/#{provider}", method: :post, data: { controller: "time-zone", action: "submit->time-zone#setAuthUrl" } do
        button_tag(type: "submit", class: button_class, &block)
      end
    end
  end
end
