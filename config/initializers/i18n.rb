Rails.application.config.after_initialize do
  require "i18n-js/listen"
  I18nJS.listen(config_file: Rails.root.join("config/i18n-js.yml"),
  locales_dir: [ Rails.root.join("config/locales"), Rails.root.join("app/views") ],
  options: { only: %r{.yml$} },
  run_on_start: false
  )
end
