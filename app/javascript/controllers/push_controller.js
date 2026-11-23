import { BridgeComponent } from "@hotwired/hotwire-native-bridge"

// Android app notifications (checkpoint I): asks the app for this phone's
// Firebase token and registers it for the signed-in person, with whether the
// phone shows Pet Tracker's notifications (app 1.0.7+; reminders are emailed
// when it doesn't). With ask (after turning reminders on) the app first asks
// for the notification permission. In a web browser the app isn't there, so
// nothing is sent.
//
// registered is the server's word on whether this sign-in has a phone. The
// server forgets the phone when the sign-in ends (signing out, expiry), but
// sessionStorage lasts for the app run, so without this a new sign-in in the
// same run would never register the phone again (reminders were emailed).
export default class extends BridgeComponent {
  static component = "push"
  static values = { url: String, ask: Boolean, registered: Boolean }

  connect() {
    super.connect()
    this.send(this.askValue ? "request" : "token", {}, (message) => this.register(message.data.token, message.data.allowed))
  }

  register(token, allowed) {
    if (!token) return
    // Once per token and setting per app run is enough, while the server still has it.
    const key = `push-token:${this.urlValue}`
    const sent = `${token}:${allowed}`
    try { if (this.registeredValue && sessionStorage.getItem(key) === sent) return } catch {}
    const body = { token: token, platform: "android" }
    if (typeof allowed === "boolean") body.notifications_allowed = allowed

    fetch(this.urlValue, {
      method: "POST",
      credentials: "same-origin",
      headers: { "Content-Type": "application/json", "X-CSRF-Token": document.querySelector("meta[name=csrf-token]")?.content },
      body: JSON.stringify(body)
    }).then((response) => {
      if (response.ok) try { sessionStorage.setItem(key, sent) } catch {}
    })
  }
}
