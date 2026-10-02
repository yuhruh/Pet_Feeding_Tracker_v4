package com.pettracker.v4

import android.net.Uri
import androidx.browser.customtabs.CustomTabsClient
import androidx.browser.customtabs.CustomTabsIntent
import dev.hotwire.navigation.activities.HotwireActivity
import dev.hotwire.navigation.navigator.NavigatorConfiguration
import dev.hotwire.navigation.routing.Router

// Google, LINE and GitHub sign-in (checkpoint I2): the app's provider buttons
// link to /auth/native/:provider, which opens in a Chrome Custom Tab so the
// whole sign-in happens in Chrome (Google doesn't allow it in a WebView). The
// server sends Chrome back with pettracker://sign-in?code=…, handled by MainActivity.
class NativeSignInRouteDecisionHandler : Router.RouteDecisionHandler {
    override val name = "native-sign-in"

    override fun matches(location: String, configuration: NavigatorConfiguration): Boolean {
        val uri = Uri.parse(location)
        val path = uri.path.orEmpty()
        return uri.host == Uri.parse(configuration.startLocation).host &&
            path.startsWith("/auth/native/") && path != "/auth/native/finish"
    }

    override fun handle(location: String, configuration: NavigatorConfiguration, activity: HotwireActivity): Router.Decision {
        val tab = CustomTabsIntent.Builder().setShowTitle(true).build()
        // In the browser, never back in this app: the app opens its own site's links.
        CustomTabsClient.getPackageName(activity, null)?.let { tab.intent.setPackage(it) }
        tab.launchUrl(activity, Uri.parse(location))
        return Router.Decision.CANCEL
    }
}
