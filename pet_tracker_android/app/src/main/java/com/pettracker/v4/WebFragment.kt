package com.pettracker.v4

import android.view.View
import android.webkit.WebView
import android.widget.Button
import android.widget.TextView
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
        return layoutInflater.inflate(R.layout.view_error, null).apply {
            findViewById<TextView>(R.id.error_message).text = error.description()
            findViewById<Button>(R.id.error_retry_button).setOnClickListener {
                refresh()
            }
        }
    }
}

@HotwireDestinationDeepLink(uri = "hotwire://fragment/web/modal")
class WebModalFragment : WebFragment() {
}
