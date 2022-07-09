document.addEventListener("DOMContentLoaded", function() {
    function readImage() {
        if (this.files && this.files[0]) {
            var file = new FileReader();
            file.onload = function(e) {
                preview.src = e.target.result;
            };       
            file.readAsDataURL(this.files[0]);
        }
    }

    user_avatar.addEventListener("change", readImage, false);
});
