require "test_helper"

# Link tokens and one-time codes must not be readable in the request log.
class SecretsInLogsTest < ActionDispatch::IntegrationTest
  def logged_path(path) = ActionDispatch::Request.new(Rails.application.env_config.merge(Rack::MockRequest.env_for(path))).filtered_path

  test "a token in the path is masked: viewer links, invitations, share links and password resets" do
    assert_equal "/en/view/[FILTERED]", logged_path("/en/view/SECRETTOKEN123")
    assert_equal "/zh-TW/join/[FILTERED]", logged_path("/zh-TW/join/SECRETTOKEN123")
    assert_equal "/shared/[FILTERED]?range=30", logged_path("/shared/SECRETTOKEN123?range=30")
    assert_equal "/en/passwords/[FILTERED]/edit", logged_path("/en/passwords/SECRETTOKEN123/edit")
    assert_equal "/en/passwords/[FILTERED]", logged_path("/en/passwords/SECRETTOKEN123")
  end

  test "paths without a token are logged as they are" do
    [ "/en/passwords/new", "/en/passwords", "/en/pets/3/trackers", "/login", "/en/viewer_links" ].each do |path|
      assert_equal path, logged_path(path)
    end
  end

  test "one-time codes and their state are masked in the query string and the parameters" do
    assert_equal "/auth/native/finish?code=[FILTERED]", logged_path("/auth/native/finish?code=SECRETCODE123")
    assert_equal "/drive_backup/callback?code=[FILTERED]&state=[FILTERED]", logged_path("/drive_backup/callback?code=SECRETCODE123&state=SECRETSTATE")

    filter = ActiveSupport::ParameterFilter.new(Rails.application.config.filter_parameters)
    assert_equal({ "code" => "[FILTERED]", "state" => "[FILTERED]", "barcode" => "4710", "provider" => "line" },
                 filter.filter("code" => "SECRETCODE123", "state" => "SECRETSTATE", "barcode" => "4710", "provider" => "line"))
  end

  test "a redirect to a link with a token is masked too" do
    locations = []
    subscriber = ActiveSupport::Notifications.subscribe("redirect_to.action_controller") { |*, payload| locations << payload[:location] }
    token = users(:one).password_reset_token
    patch password_path(token: token), params: { password: "brandnewpass1", password_confirmation: "something-else" }

    assert_match %r{/passwords/#{Regexp.escape(token)}/edit}, response.location, "the browser still gets the real address"
    assert_equal [ "[FILTERED]" ], locations
  ensure
    ActiveSupport::Notifications.unsubscribe(subscriber)
  end
end
