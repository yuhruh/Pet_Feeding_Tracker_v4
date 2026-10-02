package com.pettracker.v4

import android.Manifest
import android.app.NotificationChannel
import android.app.NotificationManager
import android.content.Context
import android.content.pm.PackageManager
import android.os.Build
import androidx.core.content.ContextCompat
import com.google.firebase.FirebaseApp
import com.google.firebase.messaging.FirebaseMessaging

// Reminder notifications (checkpoint I). Firebase is only set up when the app
// was built with the Firebase project's google-services.json; without it, push
// is simply off and the server keeps using LINE or email.
object Push {
    const val CHANNEL_ID = "reminders" // the server sends to this channel
    const val EXTRA_URL = "url" // the page a notification opens

    fun isAvailable(context: Context): Boolean = FirebaseApp.getApps(context).isNotEmpty()

    // Android 13+ asks; older versions allow notifications by default.
    fun isAllowed(context: Context): Boolean =
        Build.VERSION.SDK_INT < Build.VERSION_CODES.TIRAMISU ||
            ContextCompat.checkSelfPermission(context, Manifest.permission.POST_NOTIFICATIONS) == PackageManager.PERMISSION_GRANTED

    fun createChannel(context: Context) {
        val channel = NotificationChannel(CHANNEL_ID, context.getString(R.string.reminders_channel_name), NotificationManager.IMPORTANCE_DEFAULT).apply {
            description = context.getString(R.string.reminders_channel_description)
        }
        context.getSystemService(NotificationManager::class.java).createNotificationChannel(channel)
    }

    // The device's token, or null when push is off, not allowed or Firebase fails.
    fun token(context: Context, callback: (String?) -> Unit) {
        if (!isAvailable(context) || !isAllowed(context)) return callback(null)
        FirebaseMessaging.getInstance().token.addOnCompleteListener { task ->
            callback(if (task.isSuccessful) task.result else null)
        }
    }
}
