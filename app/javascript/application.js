// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"


document.addEventListener("DOMContentLoaded", () => {
	hideFlash();
});

function hideFlash() {
    setInterval(function() {
     	flash.classList.add('fade');
    }, 5000);
}