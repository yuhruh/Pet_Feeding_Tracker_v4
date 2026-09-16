namespace :db do
  # Run by hand: bin/rails db:backup
  #
  # Not on a schedule. In production the image has no pg_dump, and the worker has no
  # persistent disk, so a nightly dump would fail and, even if it worked, would be
  # deleted on the next deploy. Railway's managed Postgres backups cover recovery;
  # users also receive their feeding records as CSV every day (UserBackupJob).
  desc "Back up the database to a SQL file (run by hand; see config/recurring.yml)"
  task backup: :environment do
    backup_dir = Rails.root.join("storage", "backups")
    FileUtils.mkdir_p(backup_dir)

    timestamp = Time.current.strftime("%Y%m%d%H%M%S")
    db_config = ActiveRecord::Base.connection_db_config
    adapter = db_config.adapter
    output_path = backup_dir.join("pet_tracker_#{timestamp}.sql")

    case adapter
    when /postgres/
      config = db_config.configuration_hash
      pg_dump_check!(config)

      env = config[:password].present? ? { "PGPASSWORD" => config[:password] } : {}
      cmd = [ "pg_dump", "--no-owner", "--no-privileges", "-d", config[:database].to_s ]
      cmd.push("-h", config[:host].to_s) if config[:host].present?
      cmd.push("-p", config[:port].to_s) if config[:port].present?
      cmd.push("-U", config[:username].to_s) if config[:username].present?
      cmd.push("-f", output_path.to_s)

      puts "Backing up PostgreSQL database #{config[:database]} to #{output_path} ..."
      raise "pg_dump failed (exit #{$?.exitstatus}); the message above says why" unless system(env, *cmd)
    when /sqlite/
      source = Rails.root.join(db_config.database)
      puts "Copying SQLite database #{source} to #{output_path} ..."
      FileUtils.cp(source, output_path)
    else
      raise "db:backup does not support the #{adapter} adapter"
    end

    raise "#{output_path} was not created" unless File.exist?(output_path)

    puts "Backup written: #{output_path} (#{ActiveSupport::NumberHelper.number_to_human_size(File.size(output_path))})"
    warn_if_storage_is_temporary

    # keep the ten most recent
    old = Dir.glob(backup_dir.join("*.sql")).sort.reverse.drop(10)
    if old.any?
      puts "Removing #{old.size} older backup(s) ..."
      FileUtils.rm(old)
    end
  end

  # A clear message beats a bare failure: these are the two ways it breaks in practice.
  def pg_dump_check!(config)
    client = `pg_dump --version 2>/dev/null`[/\d+/]&.to_i
    raise "pg_dump is not installed here. Install the PostgreSQL client (postgresql-client-18 on Debian/Ubuntu, `brew install libpq` on macOS), or use your host's managed backups." if client.nil?

    server = ActiveRecord::Base.connection.select_value("SHOW server_version").to_s[/\d+/].to_i
    return if client >= server

    raise "pg_dump is version #{client} but the server is #{server}; pg_dump refuses to dump from a newer server. Install postgresql-client-#{server}."
  end

  def warn_if_storage_is_temporary
    return if ENV["RAILWAY_VOLUME_MOUNT_PATH"].present? || !Rails.env.production?

    puts "Note: this container has no persistent disk, so the file disappears on the next deploy. Download it now, or rely on your host's managed backups."
  end
end
