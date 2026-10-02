package com.pettracker.v4

import java.net.URI
import java.net.URISyntaxException

// Page addresses sent to PostHog, without anything secret in them: viewer links,
// invitations, share links, password resets and sign-in codes stop at the
// path, with the token itself replaced, and query strings are left out.
object AnalyticsUrl {
    private val TOKEN_AFTER = setOf("view", "join", "shared", "passwords")
    private val TOKEN_LIKE = Regex("[A-Za-z0-9_=-]{20,}")

    fun sanitize(location: String): String {
        val uri = try {
            URI(location)
        } catch (e: URISyntaxException) {
            return "unknown"
        }
        val segments = uri.rawPath.orEmpty().split("/")
        val path = segments.mapIndexed { i, segment ->
            if (isToken(segment, segments.getOrNull(i - 1))) ":token" else segment
        }.joinToString("/")
        val origin = uri.scheme?.let { "$it://${uri.rawAuthority.orEmpty()}" }.orEmpty()
        return origin + path
    }

    private fun isToken(segment: String, previous: String?): Boolean =
        (previous in TOKEN_AFTER && segment.isNotEmpty() && segment != "new") ||
            (TOKEN_LIKE.matches(segment) && segment.any { it.isUpperCase() || it.isDigit() })
}
