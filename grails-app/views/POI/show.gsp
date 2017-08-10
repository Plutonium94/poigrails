
<%@ page import="fr.mbds.tpgrails.POI" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'POI.label', default: 'POI')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
		<asset:stylesheet src="leaflet.css"/>
	</head>
	<body>
		<a href="#show-POI" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<sec:ifAnyGranted roles="ROLE_ADMINISTRATEUR,ROLE_MODERATEUR">
					<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
				</sec:ifAnyGranted>
			</ul>
		</div>
		<div id="show-POI" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list POI">
			
				<g:if test="${POIInstance?.images}">
				<li class="fieldcontain">
					<span id="images-label" class="property-label"><g:message code="POI.images.label" default="Images" /></span>
					
						<g:each in="${POIInstance.images}" var="i">
						<!--<span class="property-value" aria-labelledby="images-label"><g:link controller="image" action="show" id="${i.id}">${i?.encodeAsHTML()}</g:link></span>-->

						<img src="${grailsApplication.config.images.pois.url}${i.chemin}" title="${i.titre}" alt="${i.titre}" />
						
						</g:each>
					
				</li>
				</g:if>
			

					<g:if test="${POIInstance?.auteur}">
					<li class="fieldcontain">
						<span id="auteur-label" class="property-label"><g:message code="POI.auteur.label" default="Auteur" /></span>
							<span class="property-value" aria-labelledby="auteur-label">

								<sec:ifAnyGranted roles="ROLE_ADMINISTRATEUR,ROLE_MODERATEUR">
									<g:link controller="utilisateur" action="show" id="${POIInstance?.auteur?.id}">${POIInstance?.auteur?.encodeAsHTML()}</g:link>
								</sec:ifAnyGranted>
								<sec:ifNotGranted roles="ROLE_ADMINISTRATEUR,ROLE_MODERATEUR">
									${POIInstance?.auteur?.encodeAsHTML()}
								</sec:ifNotGranted>
									

							</span>
						
					</li>
					</g:if>
			
				<g:if test="${POIInstance?.description}">
				<li class="fieldcontain">
					<span id="description-label" class="property-label"><g:message code="POI.description.label" default="Description" /></span>
					
						<span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${POIInstance}" field="description"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${POIInstance?.groupes}">
				<li class="fieldcontain">
					<span id="groupes-label" class="property-label"><g:message code="POI.groupes.label" default="Groupes" /></span>
					
						<g:each in="${POIInstance.groupes}" var="g">
						<span class="property-value" aria-labelledby="groupes-label"><g:link controller="groupe" action="show" id="${g.id}">${g?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${POIInstance?.latitude}">
				<li class="fieldcontain">
					<span id="latitude-label" class="property-label"><g:message code="POI.latitude.label" default="Latitude" /></span>
					
						<span class="property-value" aria-labelledby="latitude-label"><g:fieldValue bean="${POIInstance}" field="latitude"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${POIInstance?.longitude}">
				<li class="fieldcontain">
					<span id="longitude-label" class="property-label"><g:message code="POI.longitude.label" default="Longitude" /></span>
					
						<span class="property-value" aria-labelledby="longitude-label"><g:fieldValue bean="${POIInstance}" field="longitude"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${POIInstance?.nom}">
				<li class="fieldcontain">
					<span id="nom-label" class="property-label"><g:message code="POI.nom.label" default="Nom" /></span>
					
						<span class="property-value" aria-labelledby="nom-label"><g:fieldValue bean="${POIInstance}" field="nom"/></span>
					
				</li>
				</g:if>
			
			</ol>

			<sec:ifAnyGranted roles="ROLE_ADMINISTRATEUR,ROLE_MODERATEUR">
			<g:form url="[resource:POIInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
						<g:link class="edit" action="edit" resource="${POIInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
						<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
			</sec:ifAnyGranted>
			<div id="cartePOI" class="cartePOI"></div>
		</div>

	<asset:javascript src="carte.js"/>
	<g:javascript >

		var lat = <g:formatNumber number="${POIInstance?.latitude}" maxFractionDigits="10"  locale="US"/>;
		var lng = <g:formatNumber number="${POIInstance?.longitude}" maxFractionDigits="10" locale="US" />;
		cartePOI(lat, lng, false);

	</g:javascript>
	
	
	</body>
</html>
