<%@ page import="fr.mbds.tpgrails.Groupe" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'groupe.label', default: 'Groupe')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
		<style>
			#groupePoiTransferDiv {
				display: flex;
				flex-flow: row nowrap;
				justify-content: space-around;
				margin-top: 5px;
			}

			.poi {
				border: 1px solid #33eebb;
				padding: 5px;
				margin-bottom: 12px;
			}

		
			#groupeMapDiv {
				width: 100%;
				height: 200px;
				margin-top: 20px;
			}
		
		</style>	
	</head>
	<body>
		<a href="#edit-groupe" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="edit-groupe" class="content scaffold-edit" role="main">
			<h1><g:message code="default.edit.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${groupeInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${groupeInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:uploadForm action="update" url="[resource:groupeInstance, action:'update']" method="PUT" >
				<g:hiddenField name="version" value="${groupeInstance?.version}" />
				<fieldset class="form">
					<g:render template="form"/>
				</fieldset>
				<fieldset class="buttons">
					<g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
				</fieldset>
			</g:uploadForm>
		</div>

		<script>
			
			<g:render template="carte" model="[pois: groupeInstance?.pois]" />

			function afterInit() {
				for(var i = 0;  i < markers.length; i++) {
					var marker = markers[i];
					marker.setDraggable(true);
					google.maps.event.addListener(marker,'dragend', function() {
						var position = this.getPosition();
						console.log('nouvelle position: ' +this.getPosition().lat() + ' ' +this.getPosition().lng());
						var xhr = new XMLHttpRequest();
						xhr.open('PUT','/vic/POI/update/'+this.locationId, true);
						xhr.responseText = 'text';
						xhr.setRequestHeader('Accept','application/json');
						xhr.setRequestHeader('Content-Type','application/json');
						xhr.onreadystatechange = function() {
							console.log(xhr.responseText);
						}
						xhr.send(JSON.stringify({latitude: position.lat(), longitude: position.lng()}));
					});
				}


			}
			
		</script>

		<script>


			function drag(evt) {
				console.log('dragged');
				//evt.preventDefault();
				evt.dataTransfer.setData('text/plain',evt.target.dataset.id);
				evt.dataTransfer.effectAllowed='move';
				console.log('data = ' + evt.dataTransfer.getData('text/plain'));
				return true;
			}

			function groupePoiListeIds() {
				var res = [];
				var groupePoiListe = document.querySelectorAll('#groupePoiListe .poi');
				for(var i=0; i < groupePoiListe.length; i++) {
					res.push(groupePoiListe[i].getAttribute("data-id"));
				}
				console.log(res);
				return res;
			}

			function tomber(evt) {
				evt.preventDefault();
				var data = evt.dataTransfer.getData('text/plain');
				var copie = document.querySelector('.poi[data-id="'+ data +'"]');
				copie.remove();
				evt.target.insertAdjacentElement('beforebegin',copie);
				var xhr = new XMLHttpRequest();
				xhr.open('PUT','/vic/groupe/update/'+${groupeInstance.id}, true);
				xhr.responseText = 'text';
				xhr.setRequestHeader('Accept','application/json');
				xhr.setRequestHeader('Content-Type','application/json');
				xhr.onreadystatechange = function() {
					console.log(xhr.responseText);
				}
				xhr.send(JSON.stringify({pois: groupePoiListeIds()}));	
			}

			function stop(evt) {
				console.log('stopped');
				evt.preventDefault();
				return false;
			}

			function fin(evt) {
				//console.log('fini');
			}

			window.onload = function(evt) {
				var pois = document.querySelectorAll('#groupePoiListe .poi');
				for(var i = 0;  i < pois.length; i++) {
					var poi = pois[i];
					
					poi.addEventListener('dragover',stop,false);
					poi.addEventListener('drop',tomber,false);
					poi.addEventListener('dragstart',drag,false);
					poi.addEventListener('dragend',fin, false);
				}

				var allPois = document.querySelectorAll('#poiListe .poi');
				for(var i = 0;  i < allPois.length; i++) {
					var poi = allPois[i];
					poi.addEventListener('dragover',stop,false);
					poi.addEventListener('drop',tomber,false);
					poi.addEventListener('dragstart',drag,false);
					poi.addEventListener('dragend',fin, false);
				}
					
			};

		</script>
		<script async defer
			src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBy8axTWFH28jT7e8Djzk78snKZ96X3r-0&callback=initMap">
    	</script>
	</body>
</html>
