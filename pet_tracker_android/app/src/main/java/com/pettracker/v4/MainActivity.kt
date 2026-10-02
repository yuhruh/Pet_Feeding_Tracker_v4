package com.pettracker.v4

import android.Manifest
import android.content.Intent
import android.os.Bundle
import android.view.View
import androidx.activity.enableEdgeToEdge
import androidx.activity.result.contract.ActivityResultContracts
import androidx.core.splashscreen.SplashScreen.Companion.installSplashScreen
import dev.hotwire.navigation.activities.HotwireActivity
import dev.hotwire.navigation.navigator.NavigatorConfiguration
import dev.hotwire.navigation.util.applyDefaultImeWindowInsets

class MainActivity : HotwireActivity() {
    // Notification permission (Android 13+), asked by the push bridge component
    // when someone turns reminders on (checkpoint I).
    private var onPermissionResult: (() -> Unit)? = null
    private val notificationPermission = registerForActivityResult(ActivityResultContracts.RequestPermission()) {
        onPermissionResult?.invoke()
        onPermissionResult = null
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        installSplashScreen()
        enableEdgeToEdge()
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        findViewById<View>(R.id.main_nav_host).applyDefaultImeWindowInsets()
    }

    override fun navigatorConfigurations() = listOf(
        NavigatorConfiguration(
            name = "main",
            // A tapped notification opens its page (the Today page).
            startLocation = notificationUrl(intent) ?: getString(R.string.home_url),
            navigatorHostId = R.id.main_nav_host
        )
    )

    // A notification tapped while the app is already open.
    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        notificationUrl(intent)?.let { delegate.currentNavigator?.route(it) }
    }

    fun requestNotificationPermission(then: () -> Unit) {
        onPermissionResult = then
        notificationPermission.launch(Manifest.permission.POST_NOTIFICATIONS)
    }

    // Only pages of this app, so a notification can't open anything else.
    private fun notificationUrl(intent: Intent?): String? =
        intent?.getStringExtra(Push.EXTRA_URL)?.takeIf { it.startsWith(getString(R.string.app_origin)) }
}
