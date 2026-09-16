namespace :security do
  desc "Replace the passwords of the given accounts, sign them out everywhere and email them how to set a new one. " \
       "Usage: EMAILS=a@example.com,b@example.com bin/rails security:force_password_reset (add CONFIRM=1 to apply)"
  task force_password_reset: :environment do
    emails = ENV.fetch("EMAILS", "").split(",").map { |email| User.normalize_value_for(:email_address, email) }.compact_blank.uniq
    abort "Set EMAILS to a comma-separated list of account emails." if emails.empty?

    users = User.where(email_address: emails).to_a
    missing = emails - users.map(&:email_address)
    puts "No account for: #{missing.join(', ')}" if missing.any?

    unless ENV["CONFIRM"] == "1"
      puts "Dry run. Would reset #{users.size} account(s): #{users.map(&:email_address).join(', ')}"
      puts "Run again with CONFIRM=1 to replace their passwords, delete their sessions and email them."
      next
    end

    failures = 0
    users.each do |user|
      User.transaction do
        # A random password no one knows. It also invalidates any reset link sent earlier.
        user.password = SecureRandom.base58(32)
        user.save!(validate: false)
        user.sessions.delete_all
      end
      SecurityMailer.password_reset_required(user).deliver_now
      puts "Reset and emailed #{user.email_address}"
    rescue StandardError => e
      failures += 1
      warn "FAILED #{user.email_address}: #{e.class}: #{e.message}"
    end

    abort "#{failures} account(s) failed; see above." if failures.positive?
  end
end
