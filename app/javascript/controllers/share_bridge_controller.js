import { BridgeComponent } from "@hotwired/hotwire-native-bridge"

export default class extends BridgeComponent {
  static componentName = "share"

  connect() {
    super.connect()
    console.log("🔗 Share Bridge Controller connected to the DOM!")
  }

  trigger(event) {
    console.log("🔘 Share button was clicked!")

    // The native bridge injects data-bridge-platform into the <html> element
    const isNative = document.documentElement.hasAttribute("data-bridge-platform")

    if (isNative) {
      console.log("📱 Running inside Native App! Sending message to iOS/Android...")
      event.preventDefault()
      event.stopImmediatePropagation() // Stop the web "copy link" controller from running

      // Grab the URL and title from the HTML data attributes
      const url = this.element.dataset.url || window.location.href
      const title = this.element.dataset.title || "Check out my pet!"

      // Send a message to the native app
      this.send("displayShareSheet", { url: url, title: title }, () => {
        console.log("✅ The native app successfully opened the share sheet!")
      })
    } else {
      console.log("🌐 Running in a standard Web Browser. Letting the web share controller handle it.")
      // We do nothing here, allowing the 'share-and-download#copy' action to run normally!
    }
  }
}
