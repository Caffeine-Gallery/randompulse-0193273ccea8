import { backend } from "declarations/backend";

let countdownValue = 30;
const numberDisplay = document.getElementById('randomNumber');
const loadingSpinner = document.getElementById('loading');
const countdownElement = document.getElementById('countdown');

async function updateRandomNumber() {
    try {
        loadingSpinner.classList.remove('d-none');
        numberDisplay.classList.add('d-none');
        
        const number = await backend.getCurrentNumber();
        
        numberDisplay.textContent = number;
        loadingSpinner.classList.add('d-none');
        numberDisplay.classList.remove('d-none');
        
        // Reset countdown
        countdownValue = 30;
        countdownElement.textContent = countdownValue;
    } catch (error) {
        console.error('Error fetching random number:', error);
        numberDisplay.textContent = 'Error loading number';
        loadingSpinner.classList.add('d-none');
        numberDisplay.classList.remove('d-none');
    }
}

// Update countdown every second
setInterval(() => {
    countdownValue--;
    if (countdownValue <= 0) {
        countdownValue = 30;
        updateRandomNumber();
    }
    countdownElement.textContent = countdownValue;
}, 1000);

// Initial load
updateRandomNumber();
