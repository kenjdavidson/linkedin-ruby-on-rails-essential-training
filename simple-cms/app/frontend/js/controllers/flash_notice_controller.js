import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect = () => {
    this.closeTimeout = setTimeout(this.closeNotice, 5000);
  };

  disconnect = () => {
    this.closeTimeout && clearTimeout(this.closeTimer);
  };

  closeNotice = () => {
    this.element.remove();
  };
}
