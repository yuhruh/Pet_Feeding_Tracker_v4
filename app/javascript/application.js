// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import { I18n } from "i18n-js"
import translations from "translations" // This refers to the pin in importmap

// 1. Create the instance
const i18n = new I18n(translations)

// 2. Setup basic config to prevent the ROUND_UP error
i18n.locale = document.documentElement.lang || "en"
i18n.enableFallback = true
i18n.defaultSeparator = "."
i18n.defaultCurrency = { format: "%u%n", unit: "$", precision: 2 }

// 3. Attach it to the window object so Stimulus controllers can use it
window.I18n = i18n

import "controllers"
import "chartkick"
import "Chart.bundle"
import "script"
import "controllers/bulk_delete_controller"