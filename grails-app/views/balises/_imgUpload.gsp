<input type="file" name="image1" />
<%--<g:textField type="text" name="image1Title" />--%>
<button type="button" id="plus">+</button>
<script>
	var compteImages = 1;

	document.getElementById('plus').onclick = function(evt)  {
		console.log('avant ' + compteImages );
		var fileInput = document.querySelector('[name="image'+ compteImages+'"]');
		++compteImages;
		var nouveauFileInput = document.createElement('input');
		nouveauFileInput.setAttribute('type', 'file');
		nouveauFileInput.setAttribute('name','image' + compteImages);
		fileInput.insertAdjacentElement('afterend',nouveauFileInput);

		/*nouveauTitreInput = document.createElement('input');
		nouveauTitreInput.setAttribute('type','text');
		nouveauTitreInput.setAttribute('name','image' + compteImages + 'Title');
		nouveauFileInput.insertAdjacentElement('afterend',nouveauTitreInput);*/
		
		console.log('apres ' +compteImages);
	};

</script>

<%-- Modify this file to update the imgUpload tag --%>