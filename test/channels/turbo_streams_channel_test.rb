require "test_helper"

# A page only hears a household it was given a signed stream name for.
class TurboStreamsChannelTest < ActionCable::Channel::TestCase
  tests Turbo::StreamsChannel

  test "a signed household stream is accepted, a made-up one is refused" do
    subscribe signed_stream_name: Turbo::StreamsChannel.signed_stream_name(households(:one))
    assert subscription.confirmed?
    assert_has_stream Turbo::StreamsChannel.send(:stream_name_from, households(:one))

    subscribe signed_stream_name: households(:two).to_gid_param
    assert subscription.rejected?
  end
end
