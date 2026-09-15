import { Controller } from "@hotwired/stimulus"

// Suggests a fix for a likely typo in the email's domain ("cat@gmial.com" → "cat@gmail.com").
// It only compares against this list of common providers and never asks the server,
// so it reveals nothing about which accounts exist.
const COMMON_DOMAINS = [
  "gmail.com", "googlemail.com", "yahoo.com", "ymail.com", "yahoo.com.tw", "yahoo.co.jp",
  "hotmail.com", "hotmail.co.jp", "outlook.com", "outlook.jp", "live.com", "msn.com",
  "icloud.com", "me.com", "mac.com", "aol.com", "proton.me", "protonmail.com", "gmx.com",
  "hinet.net", "msa.hinet.net", "docomo.ne.jp", "ezweb.ne.jp", "au.com", "softbank.ne.jp", "i.softbank.jp"
]

export default class extends Controller {
  static targets = ["input", "suggestion"]
  static values = { template: String } // e.g. "Did you mean %{email}?"

  check() {
    const suggestion = this.suggest(this.inputTarget.value.trim())
    if (!suggestion) return this.clear()

    this.suggested = suggestion
    this.suggestionTarget.textContent = this.templateValue.replace("%{email}", suggestion)
    this.suggestionTarget.hidden = false
  }

  apply() {
    if (!this.suggested) return
    this.inputTarget.value = this.suggested
    this.clear()
    this.inputTarget.focus()
  }

  clear() {
    this.suggested = null
    this.suggestionTarget.hidden = true
  }

  suggest(email) {
    const at = email.lastIndexOf("@")
    if (at < 1) return null
    const domain = email.slice(at + 1).toLowerCase()
    if (domain.length < 4 || COMMON_DOMAINS.includes(domain)) return null

    let best = null
    let bestDistance = Infinity
    for (const candidate of COMMON_DOMAINS) {
      const distance = this.distance(domain, candidate)
      const limit = candidate.length < 8 ? 1 : 2 // short domains like "me.com" only for a single slip
      if (distance <= limit && distance < bestDistance) {
        best = candidate
        bestDistance = distance
      }
    }
    return best ? `${email.slice(0, at)}@${best}` : null
  }

  // Edit distance where swapping two neighbouring letters ("gmial") counts as one edit.
  distance(a, b) {
    const d = Array.from({ length: a.length + 1 }, (_, i) => [ i, ...Array(b.length).fill(0) ])
    for (let j = 1; j <= b.length; j++) d[0][j] = j
    for (let i = 1; i <= a.length; i++) {
      for (let j = 1; j <= b.length; j++) {
        const cost = a[i - 1] === b[j - 1] ? 0 : 1
        d[i][j] = Math.min(d[i - 1][j] + 1, d[i][j - 1] + 1, d[i - 1][j - 1] + cost)
        if (i > 1 && j > 1 && a[i - 1] === b[j - 2] && a[i - 2] === b[j - 1]) {
          d[i][j] = Math.min(d[i][j], d[i - 2][j - 2] + 1)
        }
      }
    }
    return d[a.length][b.length]
  }
}
