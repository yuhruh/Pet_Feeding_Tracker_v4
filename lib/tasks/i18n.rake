namespace :i18n do
  desc "Export translations to JSON for Stimulus"
  task export: :environment do
    # Define the path to your config file
    config_path = Rails.root.join("config/i18n-js.yml").to_s

    puts "Exporting translations..."

    if system("bundle exec i18n export --config #{config_path}")
      # --- NEW WRAPPER LOGIC ---
      json_file = Rails.root.join("app/javascript/translations.json")
      js_file = Rails.root.join("app/javascript/translations.js")

      if File.exist?(json_file)
        json_content = File.read(json_file)
        # Wrap the JSON so it's a valid ES module
        File.write(js_file, "export default #{json_content};")
        puts "✅ Wrapped JSON into translations.js!"
      end
    else
      puts "❌ Export failed."
    end
  end
end

# Automatically export translations when assets are precompiled (for Render/Heroku)
Rake::Task["assets:precompile"].enhance([ "i18n:export" ])
