namespace :mail do
  desc "Report how outgoing mail and the scheduled jobs are configured and running"
  task status: :environment do
    line = "-" * 72
    puts line
    puts "Environment:      #{Rails.env}"
    puts "Delivery method:  #{ActionMailer::Base.delivery_method}"
    puts "Deliveries on:    #{ActionMailer::Base.perform_deliveries}"
    puts "From:             #{ApplicationMailer.default[:from]}"
    puts "Link host:        #{ActionMailer::Base.default_url_options[:host] || '(not set: links in emails will fail)'}"

    puts line
    puts "Gmail API credentials (values never printed):"
    GmailApiDelivery.credentials.each { |name, value| puts "  #{name}: #{value.present? ? 'set' : 'MISSING'}" }
    puts "  SendGrid api_key: #{Rails.application.credentials.dig(:sendgrid, :api_key).present? ? 'set' : 'MISSING'} (fallback)"

    puts line
    if defined?(SolidQueue::Process)
      processes = SolidQueue::Process.all
      puts "Background workers: #{processes.count}"
      processes.each { |p| puts "  #{p.kind} on #{p.hostname} - last heartbeat #{time_ago(p.last_heartbeat_at)}" }
      puts "  none running: scheduled emails and backups will not be sent" if processes.none?

      puts "Waiting jobs:     ready #{SolidQueue::ReadyExecution.count}, scheduled #{SolidQueue::ScheduledExecution.count}"

      routines = SolidQueue::RecurringTask.all
      puts "Scheduled routines:#{' none registered in this environment (config/recurring.yml lists them for production)' if routines.none?}"
      routines.each do |task|
        last_run = SolidQueue::RecurringExecution.where(task_key: task.key).maximum(:run_at)
        puts "  #{task.key} (#{task.schedule}) - last run #{last_run ? time_ago(last_run) : 'not since the last cleanup'}"
      end

      failures = SolidQueue::FailedExecution.order(created_at: :desc).limit(5)
      puts "Recent failures:  #{failures.any? ? '' : 'none'}"
      failures.each { |f| puts "  #{f.created_at.utc.strftime('%Y-%m-%d %H:%M UTC')} #{f.job.class_name}: #{f.message.to_s.lines.first.to_s.strip[0, 120]}" }
    else
      puts "Solid Queue is not loaded in this environment."
    end
    puts line
  end

  def time_ago(time)
    return "never" if time.blank?

    "#{time.utc.strftime('%Y-%m-%d %H:%M UTC')} (#{ActionController::Base.helpers.time_ago_in_words(time)} ago)"
  end
end
