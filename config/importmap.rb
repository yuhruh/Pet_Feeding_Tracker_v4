# Pin npm packages by running ./bin/importmap

pin "application"
pin "script"

pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "@hotwired--stimulus.js" # @3.2.2
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "chartkick", to: "chartkick.js"
pin "Chart.bundle", to: "Chart.bundle.js"

pin "big.js", to: "https://ga.jspm.io/npm:big.js@6.2.1/big.mjs"
pin "i18n-js", to: "https://esm.sh/i18n-js@4.5.0?bundle"
pin "translations", to: "translations.js"
pin "@hotwired/hotwire-native-bridge", to: "@hotwired--hotwire-native-bridge.js" # @1.2.2
