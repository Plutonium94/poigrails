<input type="file" name="image1" />

<button type="button" id="plus">+</button>
<script>
	var compteImages = 1;

	document.getElementById('plus').onclick = function(evt)  {
		var fileInput = document.querySelector('[file="image'+ compteImages+'"]');
		var nouveauInput = document.createElement('input');
		nouveauInput.setAttribute('type', 'file');
		nouveauInput.setAttribute('name','image ' + (++compteImages));
		fileInput.insertAdjacentElement('afterend',nouveauInput);
	};

</script>