mapboxgl.accessToken = 'pk.eyJ1IjoiLXhhbmRlLSIsImEiOiJja3k2MXZleHUwYzh1MnZscGxtdnpyY2pnIn0.2MmE9CiJ8RT-HrdX5bTdYg';

const geocoder = new MapboxGeocoder({
    accessToken: mapboxgl.accessToken,
    types: 'region,place,postcode,locality,neighborhood',
});
geocoder.addTo('#geocoder');

// Add geocoder result to container.
geocoder.on('result', (e) => {
    game_longitude.value = e.result.center[0];
    game_latitude.value = e.result.center[1];
    game_address.value = e.result.place_name;
});

// Clear results container when search is cleared.
geocoder.on('clear', () => {
    results.innerText = '';
}); 