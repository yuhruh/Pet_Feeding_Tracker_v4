import { BridgeComponent } from "@hotwired/hotwire-native-bridge"

export default class extends BridgeComponent {
  static component = "toast"

  connect() {
    super.connect()
  }

  show(event) {
    // When the button is clicked, we send a message to the native Android app
    const message = event.currentTarget.getAttribute("data-toast-message") || "Hello from Rails!"
    
    // The "show" event will be caught by the Android Kotlin component
    this.send("show", { message: message }, () => {
      // Optional callback when native replies
      console.log("Native toast was displayed!")
    })
  }
}
