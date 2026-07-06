package com.pettracker.v4

import android.view.View
import android.webkit.WebView
import android.widget.Button
import android.widget.TextView
import com.posthog.PostHog
import dev.hotwire.navigation.destinations.HotwireDestinationDeepLink
import dev.hotwire.navigation.fragments.HotwireWebFragment
import dev.hotwire.core.turbo.errors.VisitError
import dev.hotwire.core.turbo.webview.HotwireWebView

@HotwireDestinationDeepLink(uri = "hotwire://fragment/web")
open class WebFragment : HotwireWebFragment() {

    override fun onWebViewAttached(webView: HotwireWebView) {
        super.onWebViewAttached(webView)
        
        // Ensure cookies and storage are handled correctly for OAuth/OmniAuth
        val cookieManager = android.webkit.CookieManager.getInstance()
        cookieManager.setAcceptCookie(true)
        cookieManager.setAcceptThirdPartyCookies(webView, true)
        cookieManager.flush() // Force immediate cookie write
        
        webView.settings.apply {
            domStorageEnabled = true
            databaseEnabled = true
            javaScriptEnabled = true // Explicitly enable for redirects
        }
        
        // Modify User Agent to identify as Hotwire Native and avoid blocking
        val currentUserAgent = webView.settings.userAgentString
        val newUserAgent = currentUserAgent.replace("; wv", "")
            .replace("Version/\\d+\\.\\d+\\s+".toRegex(), "") + " Hotwire Native"
        
        webView.settings.userAgentString = newUserAgent
    }

    override fun createErrorView(error: VisitError): View {
        PostHog.capture(
            event = "web_page_error",
            properties = mapOf("error_description" to error.description())
        )
        val errorDescription = error.description()
        return layoutInflater.inflate(R.layout.view_error, null).apply {
            findViewById<TextView>(R.id.error_message).text = errorDescription
            findViewById<Button>(R.id.error_retry_button).setOnClickListener {
                PostHog.capture(
                    event = "error_retry_tapped",
                    properties = mapOf("error_description" to errorDescription)
                )
                refresh()
            }
        }
    }

    override fun onVisitCompleted(location: String, completedOffline: Boolean) {
        super.onVisitCompleted(location, completedOffline)
        PostHog.capture(
            event = "web_visit_completed",
            properties = mapOf(
                "location" to location,
                "completed_offline" to completedOffline
            )
        )
    }

    override fun onFormSubmissionStarted(location: String) {
        super.onFormSubmissionStarted(location)
        PostHog.capture(
            event = "web_form_submitted",
            properties = mapOf("location" to location)
        )
    }
}

@HotwireDestinationDeepLink(uri = "hotwire://fragment/web/modal")
class WebModalFragment : WebFragment() {
}
