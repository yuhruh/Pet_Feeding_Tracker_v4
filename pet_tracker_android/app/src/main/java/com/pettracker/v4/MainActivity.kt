package com.pettracker.v4

import android.Manifest
import android.content.Intent
import android.net.Uri
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
            // Back from signing in with Google, LINE or GitHub, or a tapped notification's page (Today).
            startLocation = signInFinishUrl(intent) ?: notificationUrl(intent) ?: getString(R.string.home_url),
            navigatorHostId = R.id.main_nav_host
        )
    )

    // Back from the sign-in in Chrome, or a notification tapped while the app is open.
    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        (signInFinishUrl(intent) ?: notificationUrl(intent))?.let { delegate.currentNavigator?.route(it) }
    }

    fun requestNotificationPermission(then: () -> Unit) {
        onPermissionResult = then
        notificationPermission.launch(Manifest.permission.POST_NOTIFICATIONS)
    }

    // pettracker://sign-in?code=… from Chrome (checkpoint I2): the page that signs the app in with the code.
    private fun signInFinishUrl(intent: Intent?): String? {
        val data = intent?.data ?: return null
        if (data.scheme != "pettracker" || data.host != "sign-in") return null
        val code = data.getQueryParameter("code") ?: return null
        return Uri.parse(getString(R.string.app_origin)).buildUpon()
            .path("auth/native/finish").appendQueryParameter("code", code).build().toString()
    }

    // Only pages of this app, so a notification can't open anything else.
    private fun notificationUrl(intent: Intent?): String? =
        intent?.getStringExtra(Push.EXTRA_URL)?.takeIf { it.startsWith(getString(R.string.app_origin)) }
}
