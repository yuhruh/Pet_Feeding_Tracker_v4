package com.pettracker.v4

import dev.hotwire.core.bridge.BridgeComponent
import dev.hotwire.core.bridge.BridgeDelegate
import dev.hotwire.core.bridge.Message
import dev.hotwire.navigation.destinations.HotwireDestination
import org.json.JSONObject

// The "push" bridge component (checkpoint I): signed-in pages ask for this
// phone's notification token and send it to the server. "token" answers only
// when notifications are already allowed; "request" (after turning reminders
// on) asks for the permission first, on Android 13+.
class PushComponent(
    name: String,
    private val delegate: BridgeDelegate<HotwireDestination>
) : BridgeComponent<HotwireDestination>(name, delegate) {

    override fun onReceive(message: Message) {
        when (message.event) {
            "token" -> replyWithToken(message)
            "request" -> requestThenReply(message)
        }
    }

    private fun requestThenReply(message: Message) {
        val activity = delegate.destination.fragment.activity as? MainActivity ?: return replyWithToken(message)
        if (!Push.isAvailable(activity) || Push.isAllowed(activity)) return replyWithToken(message)
        activity.requestNotificationPermission { replyWithToken(message) }
    }

    private fun replyWithToken(message: Message) {
        val context = delegate.destination.fragment.context ?: return
        Push.token(context) { token ->
            val data = JSONObject().apply { if (token != null) put("token", token) }
            delegate.destination.fragment.activity?.runOnUiThread { replyTo(message.event, data.toString()) }
        }
    }
}
