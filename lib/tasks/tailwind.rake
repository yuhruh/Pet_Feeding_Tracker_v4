# lib/tasks/tailwind.rake
# Overriding the tailwindcss:build task to specify the config file path explicitly
# and ensure it runs from the project root directory.

namespace :tailwindcss do
  # Remove the existing definition of the task.
  Rake::Task["build"].clear if Rake::Task.task_defined?("build")

  desc "Build your Tailwind CSS with explicit config path from the project root"
  task :build do
    # Ensure we are in the project root directory.
    Dir.chdir(Rails.root) do
      command = "npx tailwindcss -i ./app/assets/tailwind/application.css -o ./app/assets/builds/tailwind.css -c ./config/tailwind.config.js --minify"

      puts 'Running custom Tailwind CSS build command from '#{Dir.pwd}'...'

      unless system(command)
        abort "Tailwind CSS build failed."
      end
    end
  end
end
