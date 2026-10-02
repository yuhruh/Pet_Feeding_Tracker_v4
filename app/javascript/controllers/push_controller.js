import { BridgeComponent } from "@hotwired/hotwire-native-bridge"

// Android app notifications (checkpoint I): asks the app for this phone's
// Firebase token and registers it for the signed-in person. With ask (after
// turning reminders on) the app first asks for the notification permission.
// In a web browser the app isn't there, so nothing is sent.
export default class extends BridgeComponent {
  static component = "push"
  static values = { url: String, ask: Boolean }

  connect() {
    super.connect()
    this.send(this.askValue ? "request" : "token", {}, (message) => this.register(message.data.token))
  }

  register(token) {
    if (!token) return
    // Once per token per app session is enough; the server keeps it after that.
    const key = `push-token:${this.urlValue}`
    try { if (sessionStorage.getItem(key) === token) return } catch {}

    fetch(this.urlValue, {
      method: "POST",
      credentials: "same-origin",
      headers: { "Content-Type": "application/json", "X-CSRF-Token": document.querySelector("meta[name=csrf-token]")?.content },
      body: JSON.stringify({ token: token, platform: "android" })
    }).then((response) => {
      if (response.ok) try { sessionStorage.setItem(key, token) } catch {}
    })
  }
}
