package com.pettracker.v4

import org.junit.Assert.assertEquals
import org.junit.Test

class AnalyticsUrlTest {
    private val site = "https://pet-tracker.example"

    @Test
    fun keepsOrdinaryPages() {
        assertEquals("$site/en/pets/3/trackers", AnalyticsUrl.sanitize("$site/en/pets/3/trackers?range=7"))
        assertEquals("$site/ja/household_care_records", AnalyticsUrl.sanitize("$site/ja/household_care_records#top"))
        assertEquals("$site/en/passwords/new", AnalyticsUrl.sanitize("$site/en/passwords/new"))
    }

    @Test
    fun hidesTokensInPaths() {
        assertEquals("$site/en/view/:token", AnalyticsUrl.sanitize("$site/en/view/abc"))
        assertEquals("$site/zh-TW/join/:token", AnalyticsUrl.sanitize("$site/zh-TW/join/Xy_9-kLmN"))
        assertEquals("$site/en/shared/:token", AnalyticsUrl.sanitize("$site/en/shared/q1w2e3r4t5y6u7i8o9p0AsDf"))
        assertEquals("$site/en/passwords/:token/edit", AnalyticsUrl.sanitize("$site/en/passwords/eyJfcmFpbHMiOnsiZGF0YSI6WzFd==--a1b2c3/edit"))
        assertEquals("$site/en/somewhere/:token", AnalyticsUrl.sanitize("$site/en/somewhere/Q9vXk2mZpL0aR7tYw3eN5uB8"))
    }

    @Test
    fun dropsQueryStringsAndOddInput() {
        assertEquals("$site/auth/native/finish", AnalyticsUrl.sanitize("$site/auth/native/finish?code=secret"))
        assertEquals("pettracker://sign-in", AnalyticsUrl.sanitize("pettracker://sign-in?code=secret"))
        assertEquals("unknown", AnalyticsUrl.sanitize("https://bad host/"))
    }
}
