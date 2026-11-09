require "test_helper"
require "fugit"

# Solid Queue skips a task whose schedule it cannot read as repeating, so a typo
# means the job silently never runs. ("at 6am on the 1st of every month" reads
# as one date, not a monthly schedule.)
class RecurringScheduleTest < ActiveSupport::TestCase
  test "every production task has a valid, repeating schedule and a job that exists" do
    tasks = YAML.load_file(Rails.root.join("config/recurring.yml")).fetch("production")

    tasks.each do |key, options|
      task = SolidQueue::RecurringTask.new(key: key, schedule: options["schedule"], class_name: options["class"], command: options["command"])
      assert task.valid?, "#{key}: #{task.errors.full_messages.to_sentence}"
      assert options["class"].safe_constantize, "#{key}: no class #{options['class']}" if options["class"]
    end
  end

  # Rake::Task#invoke runs a task once per process, so a scheduled rake command
  # stops after the worker's first run (the weight reminders did until Nov 2026).
  test "no task runs a rake task" do
    tasks = YAML.load_file(Rails.root.join("config/recurring.yml")).fetch("production")

    tasks.each { |key, options| assert_no_match(/Rake::Task/, options["command"].to_s, key) }
  end

  test "weight reminders run every hour as a job" do
    task = YAML.load_file(Rails.root.join("config/recurring.yml")).dig("production", "pet_weight_reminders")

    assert_equal "PetWeightRemindersJob", task["class"]
    assert_equal "10 * * * *", Fugit.parse(task["schedule"]).to_cron_s
  end

  test "kibble prices are checked once a month" do
    schedule = YAML.load_file(Rails.root.join("config/recurring.yml")).dig("production", "monthly_kibble_prices", "schedule")

    assert_equal "0 6 1 * *", Fugit.parse(schedule).to_cron_s
  end
end
