
function cartePOI(latitude, longitude, editable, create, applicationName, id) {
	var x = latitude; 
	var y = longitude;

	if(create) {
		x = 43.710367;
		y = 7.269066;
	}


	var carte = L.map('cartePOI').setView([x, y],  create?12:18);


	L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
		attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
	}).addTo(carte);

	var marker = L.marker([x,y], {draggable: editable}).addTo(carte);

	if(editable) {
		marker.on('dragend', function(evt) {
			var np = evt.target._latlng;
			if(applicationName && id) {
				$.post('/' + applicationName + '/POI/updateCoordinates', {id: id, latitude: np.lat, longitude: np.lng}, function(data) {
					$('#latitude').val(data.latitude);
					$('#longitude').val(data.longitude);
				});
				
			}
		});
	}
}