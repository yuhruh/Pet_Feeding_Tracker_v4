namespace :db do
  desc "Backup the database to a SQL file"
  task backup: :environment do
    backup_dir = Rails.root.join("storage", "backups")
    FileUtils.mkdir_p(backup_dir)

    timestamp = Time.current.strftime("%Y%m%d%H%M%S")
    db_config = ActiveRecord::Base.connection_db_config
    adapter = db_config.adapter

    filename = "railsway_#{timestamp}.sql"
    output_path = backup_dir.join(filename)

    case adapter
    when "postgresql"
      # For PostgreSQL
      db_name = db_config.database
      username = db_config.configuration_hash[:username]
      password = db_config.configuration_hash[:password]
      host = db_config.configuration_hash[:host] || "localhost"

      env = {}
      env["PGPASSWORD"] = password if password.present?

      cmd = [ "pg_dump" ]
      cmd << "-h" << host if host.present?
      cmd << "-U" << username if username.present?
      cmd << "-d" << db_name
      cmd << "-f" << output_path.to_s

      puts "Backing up PostgreSQL database #{db_name} to #{output_path}..."
      system(env, *cmd)
    when "sqlite3"
      # For SQLite, we can just copy the file
      db_path = db_config.database
      puts "Backing up SQLite database #{db_path} to #{output_path}..."
      FileUtils.cp(Rails.root.join(db_path), output_path)
    else
      puts "Adapter #{adapter} is not supported for automatic SQL backup yet."
      exit 1
    end

    if File.exist?(output_path)
      puts "Backup successful: #{output_path}"
      # Keep only last 10 backups
      old_backups = Dir.glob(backup_dir.join("railsway_*.sql")).sort.reverse.slice(10..-1)
      if old_backups&.any?
        puts "Cleaning up #{old_backups.size} old backups..."
        FileUtils.rm(old_backups)
      end
    else
      puts "Backup failed!"
      exit 1
    end
  end
end
