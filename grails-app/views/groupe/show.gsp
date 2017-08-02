
<%@ page import="fr.mbds.tpgrails.Groupe" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'groupe.label', default: 'Groupe')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
		<style>
			#groupeMapDiv {
				width: 100%;
				height: 200px;
			}
		</style>		
	</head>
	<body>
		<a href="#show-groupe" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<sec:ifAnyGranted roles="ROLE_ADMINISTRATEUR,ROLE_MODERATEUR">
					<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
				</sec:ifAnyGranted>
			</ul>
		</div>
		<div id="show-groupe" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list groupe">

				<g:if test="${groupeInstance?.nom}">
				<li class="fieldcontain">
					<span id="nom-label" class="property-label"><g:message code="groupe.nom.label" default="Nom" /></span>
					
						<g:link controller="groupe" action="show" id="${groupeInstance?.id}">
							<span class="property-value" aria-labelledby="nom-label"><g:fieldValue bean="${groupeInstance}" field="nom"/></span>
						</g:link>
					
				</li>
				</g:if>

				<g:if test="${groupeInstance?.images}">
				<li class="fieldcontain">
					<span id="images-label" class="property-label"><g:message code="groupe.images.label" default="Images" /></span>
					
						<g:each in="${groupeInstance.images}" var="i">
						<span class="property-value" aria-labelledby="images-label"><g:link controller="image" action="show" id="${i.id}">${i?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${groupeInstance?.pois}">
				<li class="fieldcontain">
					<span id="pois-label" class="property-label"><g:message code="groupe.pois.label" default="Pois" /></span>

						<p>Total pois : ${groupeInstance.pois.size()}</p>
					
						<g:each in="${groupeInstance.pois}" var="p">
							<span class="property-value" aria-labelledby="pois-label">
								<g:link controller="POI" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link>
							</span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${groupeInstance?.auteur}">
				<li class="fieldcontain">
					<span id="auteur-label" class="property-label"><g:message code="groupe.auteur.label" default="Auteur" /></span>
					
						<span class="property-value" aria-labelledby="auteur-label">

							<sec:ifAnyGranted roles="ROLE_ADMINISTRATEUR,ROLE_MODERATEUR">

								<g:link controller="utilisateur" action="show" id="${groupeInstance?.auteur?.id}">${groupeInstance?.auteur?.encodeAsHTML()}</g:link>

							</sec:ifAnyGranted>

							<sec:ifNotGranted roles="ROLE_ADMINISTRATEUR,ROLE_MODERATEUR">
								${groupeInstance?.auteur?.encodeAsHTML()}
							</sec:ifNotGranted>

						</span>
					
				</li>
				</g:if>

			
			
			</ol>

			<div id="groupeMapDiv"></div>

			<sec:ifAnyGranted roles="ROLE_ADMINISTRATEUR,ROLE_MODERATEUR">
				<g:form url="[resource:groupeInstance, action:'delete']" method="DELETE">
					<fieldset class="buttons">
						<g:link class="edit" action="edit" resource="${groupeInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
						<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
					</fieldset>
				</g:form>
			</sec:ifAnyGranted>
		</div>

		<script>
			
			<g:render template="carte" model="[pois: groupeInstance?.pois]" />

			function afterInit() {}
			
		</script>
		<script async defer
			src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBy8axTWFH28jT7e8Djzk78snKZ96X3r-0&callback=initMap">
    	</script>
	</body>
</html>
