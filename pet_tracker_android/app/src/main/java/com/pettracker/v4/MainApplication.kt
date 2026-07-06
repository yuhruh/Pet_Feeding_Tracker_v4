package com.pettracker.v4

import android.app.Application
import com.posthog.android.PostHogAndroid
import com.posthog.android.PostHogAndroidConfig
import dev.hotwire.core.config.Hotwire
import dev.hotwire.core.turbo.config.PathConfiguration
import dev.hotwire.core.bridge.BridgeComponentFactory
import dev.hotwire.navigation.config.registerBridgeComponents

class MainApplication : Application() {
    override fun onCreate() {
        super.onCreate()

        val config = PostHogAndroidConfig(
            apiKey = BuildConfig.POSTHOG_API_KEY,
            host = BuildConfig.POSTHOG_HOST,
        ).apply {
            captureApplicationLifecycleEvents = true
            captureScreenViews = true
            captureDeepLinks = true
            errorTrackingConfig.autoCapture = true
        }
        PostHogAndroid.setup(this, config)

        Hotwire.loadPathConfiguration(
            context = this,
            location = PathConfiguration.Location(
                assetFilePath = "json/path-configuration.json"
            )
        )

        // Register Strata Bridge Components
        Hotwire.registerBridgeComponents(
            BridgeComponentFactory("toast") { name, delegate ->
                ToastComponent(name, delegate)
            }
        )
    }
}
