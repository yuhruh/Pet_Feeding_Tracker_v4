# Pin npm packages by running ./bin/importmap

pin "application"
pin "script"

pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "@hotwired--stimulus.js" # @3.2.2
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "echarts", to: "echarts.js" # @6.1.0

# Both are files in vendor/javascript, not CDN addresses: a script loaded from
# someone else's server runs with the signed-in person's access to this site.
pin "big.js" # @6.2.1
pin "i18n-js", to: "i18n-js.bundle.js" # @4.5.0, the esm.sh bundle (dependencies included)
pin "translations", to: "translations.js"
pin "@hotwired/hotwire-native-bridge", to: "@hotwired--hotwire-native-bridge.js" # @1.2.2
