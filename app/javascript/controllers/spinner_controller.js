import { Turbo } from "@hotwired/turbo-rails";
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = [ "spinner" ]
  
  connect() { 
    const spinner = `
      <div class="hidden fixed flex flex-col h-full w-full justify-center left-0 top-0" data-spinner-target="spinner">
        <div class="absolute bg-gray-200 opacity-80 w-full h-full"></div>
        <div class="flex justify-center">
          <svg class="animate-spin h-12 w-12 text-blue-500" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
            <circle class="opacity-25" cx="12" cy="12" r="10" stroke="#79B20E" stroke-width="4"></circle>
            <path class="opacity-75" fill="#79B20E" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
          </svg>
        </div>
      </div>
    `;
    
    document.body.insertAdjacentHTML('beforeend', spinner);
  }
  
  disconnect() { 
    if (this.hasSpinnerTarget) 
      this.spinnerTarget.classList.add('hidden');
  }

  show() {
    if (this.hasSpinnerTarget) 
      this.spinnerTarget.classList.remove('hidden');
  }
}