navigator.geolocation.getCurrentPosition(function(position) {
    const lat = position.coords.latitude;
    const long = position.coords.longitude;

    let list_sports = document.querySelectorAll(".link-sport");

    for (let i = 0; i < list_sports.length; i++){
		list_sports[i].href += "?lat=" + lat + "&lon=" + long; 
    }
});