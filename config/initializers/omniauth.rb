# Load credentials as constants to ensure they are available immediately
LINE_ID = ENV["LINE_CHANNEL_ID"] || Rails.application.credentials.dig(:line, :client_id)
LINE_SECRET = ENV["LINE_CHANNEL_SECRET"] || Rails.application.credentials.dig(:line, :client_secret)

GOOGLE_ID = ENV["GOOGLE_CLIENT_ID"] || Rails.application.credentials.dig(:google, :client_id)
GOOGLE_SECRET = ENV["GOOGLE_CLIENT_SECRET"] || Rails.application.credentials.dig(:google, :client_secret)

GITHUB_ID = ENV["GITHUB_CLIENT_ID"] || Rails.application.credentials.dig(:github, :client_id)
GITHUB_SECRET = ENV["GITHUB_CLIENT_SECRET"] || Rails.application.credentials.dig(:github, :client_secret)

# Force printing to console for debugging
STDOUT.puts "DEBUG: LINE_ID is #{LINE_ID.present? ? 'LOADED' : 'MISSING'}"
STDOUT.puts "DEBUG: GOOGLE_ID is #{GOOGLE_ID.present? ? 'LOADED' : 'MISSING'}"
STDOUT.puts "DEBUG: GITHUB_ID is #{GITHUB_ID.present? ? 'LOADED' : 'MISSING'}"

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer if Rails.env.development?

  # GOOGLE
  provider :google_oauth2, GOOGLE_ID, GOOGLE_SECRET,
          { scope: "email, profile",
            callback_path: "/auth/google_oauth2/callback",
            request_path: "/auth/google_oauth2",
            provider_ignores_state: true,
            setup: lambda { |env|
              env["rack.input"] ||= StringIO.new("")
            }
          }

  # LINE
  provider :line, LINE_ID, LINE_SECRET,
          { scope: "profile openid email",
            callback_path: "/auth/line/callback",
            request_path: "/auth/line",
            provider_ignores_state: true,
            setup: lambda { |env|
              env["rack.input"] ||= StringIO.new("")
            }
          }

  # GITHUB
  provider :github, GITHUB_ID, GITHUB_SECRET,
          { scope: "user:email",
            callback_path: "/auth/github/callback",
            request_path: "/auth/github",
            provider_ignores_state: true,
            setup: lambda { |env|
              env["rack.input"] ||= StringIO.new("")
            }
          }

  OmniAuth.config.on_failure = Proc.new do |env|
    exception = env["omniauth.error"]
    if exception
      Rails.logger.error "OmniAuth Error: #{exception.class} - #{exception.message}"
      Rails.logger.error exception.backtrace.join("\n")
    end
    OmniAuth::FailureEndpoint.new(env).redirect_to_failure
  end
end
