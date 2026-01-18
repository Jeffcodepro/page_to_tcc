import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { timeout: { type: Number, default: 6000 } }

  connect() {
    this.hideAfterDelay()
  }

  hideAfterDelay() {
    if (this.timeoutValue <= 0) return
    this.timer = setTimeout(() => this.dismiss(), this.timeoutValue)
  }

  dismiss() {
    this.element.classList.add('alert-toast--hide')
    setTimeout(() => { this.element.remove() }, 220)
  }

  clear() {
    if (this.timer) clearTimeout(this.timer)
  }
}
