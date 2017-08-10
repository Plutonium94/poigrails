
function cartePOI(latitude, longitude, editable) {
	var x = latitude; //<g:formatNumber number="${POIInstance?.latitude}" maxFractionDigits="10"  locale="US"/>;
	var y = longitude; //<g:formatNumber number="${POIInstance?.longitude}" maxFractionDigits="10" locale="US" />;

	var carte = L.map('cartePOI').setView([x, y],  18);


	L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
		attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
	}).addTo(carte);

	var marker = L.marker([x,y], {draggable: editable}).addTo(carte);
}