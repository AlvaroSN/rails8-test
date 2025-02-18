import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
	static targets = ["header", "button", "adminMenu", "openMenu", "closeMenu"];

	connect() {}

	toggleUserMenu() {
		if (this.buttonTarget.classList.contains("closed")) {
			this.openUserMenu();
		} else {
			this.closeUserMenu();
		}
		this.buttonTarget.classList.toggle("closed");
  }
  
	openUserMenu() {
		this.headerTarget.classList.remove("hidden");
		setTimeout(() => {
			this.headerTarget.classList.remove("-translate-y-full");
			this.openMenuTarget.classList.add("hidden");
			this.closeMenuTarget.classList.remove("hidden");
		}, 300);
  }
  
	closeUserMenu() {
		this.headerTarget.classList.add("-translate-y-full");
		setTimeout(() => {
			this.headerTarget.classList.add("hidden");
			this.openMenuTarget.classList.remove("hidden");
			this.closeMenuTarget.classList.add("hidden");
		}, 300);
	}

	toggleAdminMenu() {
		if (this.adminMenuTarget.classList.contains("hidden")) {
			this.openAdminMenu();
		} else {
			this.closeAdminMenu();
		}
  }
  
	openAdminMenu() {
		this.adminMenuTarget.classList.remove("hidden");
		this.adminMenuTarget.classList.add("flex");
		setTimeout(() => {
			this.adminMenuTarget.classList.remove("-translate-x-full");
		}, 300);
  }
  
	closeAdminMenu() {
		this.adminMenuTarget.classList.add("-translate-x-full");
		setTimeout(() => {
			this.adminMenuTarget.classList.remove("flex");
			this.adminMenuTarget.classList.add("hidden");
		}, 300);
	}
}
