package com.pettracker.v4

import android.widget.Toast
import com.posthog.PostHog
import dev.hotwire.core.bridge.BridgeComponent
import dev.hotwire.core.bridge.BridgeDelegate
import dev.hotwire.core.bridge.Message
import dev.hotwire.navigation.destinations.HotwireDestination

class ToastComponent(
    name: String,
    private val delegate: BridgeDelegate<HotwireDestination>
) : BridgeComponent<HotwireDestination>(name, delegate) {

    override fun onReceive(message: Message) {
        when (message.event) {
            "show" -> showToast(message)
        }
    }

    private fun showToast(message: Message) {
        val json = org.json.JSONObject(message.jsonData)
        val text = json.optString("message", "Default Toast message")

        PostHog.capture(
            event = "toast_shown",
            properties = mapOf("message" to text)
        )

        replyWith(message)

        val context = delegate.destination.fragment.requireContext()
        delegate.destination.fragment.requireActivity().runOnUiThread {
            Toast.makeText(context, text, Toast.LENGTH_SHORT).show()
        }
    }
}
