import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["disliked", "liked"];
  static values = { user: String, product: String };

  connect() { }

  like() {
    let like = false;
    fetch(`/likes/${this.productValue}`, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
      },
    })
      .then((response) => {
        if (response.ok) {
          like = true;
          return response.json();
        } else if (response.status === 401) {
          alert("Debes inciar sesión para realizar esta acción")
          window.location.href = "/users/sign_in";
        } else {
          throw new Error("Error al crear el like");
        }
      })
      .then((data) => {
        if (like) {
          this.dislikedTarget.classList.add("hidden");
          this.show(this.likedTarget);
        }
      })
      .catch((error) => {
        console.error(error);
      });
  }

  dislike() {

    fetch(`/likes/${this.productValue}`, {
      method: "DELETE",
      headers: {
        "Content-Type": "application/json",
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
      },
    })
      .then((response) => {
        if (response.ok) {
          return response.json();
        } else if (response.status === 401) {
          alert("Debes inciar sesión para realizar esta acción");
          window.location.href = "/users/sign_in";
        } else {
          throw new Error("Error al eliminar el like");
        }
      })
      .then((data) => {
        this.likedTarget.classList.add("hidden");
        this.show(this.dislikedTarget);
      })
      .catch((error) => {
        console.error(error);
      });
  }

  show(target) {
    target.classList.remove("hidden");
    target.children[1].classList.add("animate-ping");
    setTimeout(function () {
      target.children[1].classList.remove("animate-ping");
    }, 600);
  }
  
}
