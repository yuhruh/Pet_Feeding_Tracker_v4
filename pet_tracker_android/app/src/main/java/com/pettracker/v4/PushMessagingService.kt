package com.pettracker.v4

import android.app.PendingIntent
import android.content.Intent
import androidx.core.app.NotificationCompat
import androidx.core.app.NotificationManagerCompat
import com.google.firebase.messaging.FirebaseMessagingService
import com.google.firebase.messaging.RemoteMessage

// Receives reminder notifications (checkpoint I). In the background Android
// shows them itself and a tap opens MainActivity with the "url" extra; with the
// app open, they arrive here and are shown the same way.
class PushMessagingService : FirebaseMessagingService() {

    // A new token is sent to the server by the push bridge component on the next page load.
    override fun onNewToken(token: String) = Unit

    override fun onMessageReceived(message: RemoteMessage) {
        if (!Push.isAllowed(this)) return
        val notification = message.notification ?: return
        val intent = Intent(this, MainActivity::class.java).apply {
            addFlags(Intent.FLAG_ACTIVITY_SINGLE_TOP or Intent.FLAG_ACTIVITY_CLEAR_TOP)
            message.data[Push.EXTRA_URL]?.let { putExtra(Push.EXTRA_URL, it) }
        }
        val tap = PendingIntent.getActivity(this, message.messageId.hashCode(), intent, PendingIntent.FLAG_IMMUTABLE or PendingIntent.FLAG_UPDATE_CURRENT)
        val shown = NotificationCompat.Builder(this, Push.CHANNEL_ID)
            .setSmallIcon(R.mipmap.ic_launcher)
            .setContentTitle(notification.title)
            .setContentText(notification.body)
            .setStyle(NotificationCompat.BigTextStyle().bigText(notification.body))
            .setAutoCancel(true)
            .setContentIntent(tap)
            .build()
        try {
            NotificationManagerCompat.from(this).notify(message.messageId.hashCode(), shown)
        } catch (_: SecurityException) {
            // Permission withdrawn in the meantime.
        }
    }
}
