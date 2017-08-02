var  map, bounds;
var locations = [];
var markers = [];

<g:each in="${pois}" var="p" status="k">
	locations.push([${p?.latitude},${p?.longitude},"${p?.nom}", ${p?.id}]);
</g:each>

function initMap() {
	console.log('initMap called');
	bounds = new google.maps.LatLngBounds();
	map = new google.maps.Map(document.getElementById('groupeMapDiv'), 
		{center: {lat: -34.397, lng:150.644}, zoom: 8});
	for(var i= 0;  i < locations.length; i++) {
		var marker = new google.maps.Marker({
			position: new google.maps.LatLng(locations[i][0], locations[i][1]),
			map: map
		});
		marker.locationId = locations[i][3];
		bounds.extend(marker.position);

		var infowindow = new google.maps.InfoWindow();
		google.maps.event.addListener(marker, 'click', (function(marker,i) {
			return function() {
				console.log(locations[i][2]);
				infowindow.setContent( locations[i][2]);
				infowindow.open(map, marker);
			}
		})(marker, i));

		markers.push(marker);
	}
	map.fitBounds(bounds);
	afterInit();
}
