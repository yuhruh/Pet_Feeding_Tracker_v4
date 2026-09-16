namespace :gmail do
  desc "Send one real test email with the current settings (TO=someone@example.com to choose the recipient)"
  task test_email: :environment do
    # ApplicationMailer, not ActionMailer::Base: that is where this app sets the sender.
    recipient = ENV["TO"].presence || ApplicationMailer.default[:from]
    abort "No recipient: pass TO=someone@example.com" if recipient.blank?

    puts "Sending a test email to #{recipient} via #{ActionMailer::Base.delivery_method} ..."
    DiagnosticsMailer.test_email(to: recipient).deliver_now
    puts "Sent. Check that inbox, and the Sent folder of the sending account."
  rescue => e
    abort "Sending failed: #{e.class}: #{e.message}"
  end

  desc "One-off: get a Gmail API refresh token for the sending account (run locally)"
  task :refresh_token do
    require "net/http"
    require "uri"
    require "json"
    require "socket"
    require "securerandom"

    PORT = 8080
    REDIRECT_URI = "http://localhost:#{PORT}".freeze
    SCOPE = "https://www.googleapis.com/auth/gmail.send".freeze

    def ask(prompt)
      print "#{prompt}: "
      value = $stdin.gets.to_s.strip
      abort "Nothing entered, stopping." if value.empty?
      value
    end

    puts <<~SETUP
      Before running this, in the Google Cloud console (https://console.cloud.google.com), signed in
      as the SENDING account:
        1. Create (or pick) a project, then enable the "Gmail API".
        2. OAuth consent screen: User type "External", add the sending account as a test user,
           then set Publishing status to "In production" (otherwise the refresh token expires
           after about a week). An "unverified app" warning is expected: continue past it.
        3. Credentials -> Create credentials -> OAuth client ID -> Application type "Web application",
           and add this Authorized redirect URI: #{REDIRECT_URI}
        4. Copy the client ID and client secret below.

    SETUP

    client_id = ENV["GMAIL_CLIENT_ID"] || ask("Client ID")
    client_secret = ENV["GMAIL_CLIENT_SECRET"] || ask("Client secret (not printed again)")
    state = SecureRandom.hex(16)

    authorize_url = "https://accounts.google.com/o/oauth2/v2/auth?" + URI.encode_www_form(
      client_id: client_id, redirect_uri: REDIRECT_URI, response_type: "code", scope: SCOPE,
      access_type: "offline", prompt: "consent", state: state
    )

    puts "\nOpen this URL, sign in as the sending account and approve:\n\n#{authorize_url}\n\n"
    puts "Waiting for Google to redirect back to #{REDIRECT_URI} ..."

    server = TCPServer.new("127.0.0.1", PORT)
    socket = server.accept
    request_line = socket.gets.to_s
    params = URI.decode_www_form(URI(request_line.split(" ")[1].to_s).query.to_s).to_h
    socket.print "HTTP/1.1 200 OK\r\nContent-Type: text/plain\r\n\r\n"
    socket.print(params["code"] ? "Done. You can close this tab and return to the terminal." : "No code received.")
    socket.close
    server.close

    abort "Google returned an error: #{params['error']}" if params["error"]
    abort "No authorization code received." if params["code"].blank?
    abort "State did not match; start again." unless params["state"] == state

    response = Net::HTTP.post_form(URI("https://oauth2.googleapis.com/token"),
      code: params["code"], client_id: client_id, client_secret: client_secret,
      redirect_uri: REDIRECT_URI, grant_type: "authorization_code")
    body = JSON.parse(response.body) rescue {}

    unless response.code.to_i == 200 && body["refresh_token"].present?
      abort "Token exchange failed (#{response.code}): #{body['error_description'] || body['error'] || response.body}"
    end

    puts <<~DONE

      Refresh token (store it, it is shown only once):

        #{body["refresh_token"]}

      Then set these three on the server (or add them under gmail_api in credentials):

        GMAIL_CLIENT_ID=#{client_id}
        GMAIL_CLIENT_SECRET=(the client secret you entered)
        GMAIL_REFRESH_TOKEN=(the token above)

      Production switches to the Gmail API automatically once GMAIL_REFRESH_TOKEN is set.
      Check it afterwards with:  bin/rails runner 'PasswordsMailer.reset(User.first).deliver_now'
    DONE
  end
end
