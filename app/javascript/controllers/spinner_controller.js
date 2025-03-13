import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = { hide: Boolean, delay: Number };
  
  connect() { 
    const spinner = `
      <div id="stimulusSpinner" class="hidden fixed flex flex-col h-full w-full justify-center left-0 top-0 z-50">
        <div class="absolute bg-gray-200 opacity-80 w-full h-full"></div>
        <div class="flex justify-center">
          <svg class='animate-spin h-20 w-20 text-blue-500' xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 24 24'>
            <circle class='opacity-25' cx='12' cy='12' r='10' stroke='currentColor' stroke-width='4'></circle>
            <path class='opacity-75' fill='currentColor' d='M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z'></path>
          </svg>
        </div>
      </div>
    `;
    document.body.insertAdjacentHTML('beforeend', spinner);

    document.addEventListener('turbo:submit-end', this.hide.bind(this));
  }
  
  disconnect() { 
    this.hide();
  }

  hide() {
    const spinner = document.getElementById('stimulusSpinner');
    if (spinner) 
      spinner.classList.add('hidden');
  }

  show() {
    const spinner = document.getElementById('stimulusSpinner');
    if (spinner) 
      spinner.classList.remove('hidden');
  }
}