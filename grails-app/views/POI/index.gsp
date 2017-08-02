
<%@ page import="fr.mbds.tpgrails.POI" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'POI.label', default: 'POI')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
		<asset:stylesheet src="leaflet.css"/>
	</head>
	<body>
		<a href="#list-POI" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<sec:ifAnyGranted roles="ROLE_ADMINISTRATEUR,ROLE_MODERATEUR">
					<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
				</sec:ifAnyGranted>
			</ul>
		</div>
		<div id="list-POI" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<th><g:message code="POI.auteur.label" default="Auteur" /></th>
					
						<g:sortableColumn property="description" title="${message(code: 'POI.description.label', default: 'Description')}" />
					
						<g:sortableColumn property="latitude" title="${message(code: 'POI.latitude.label', default: 'Latitude')}" />
					
						<g:sortableColumn property="longitude" title="${message(code: 'POI.longitude.label', default: 'Longitude')}" />
					
						<g:sortableColumn property="nom" title="${message(code: 'POI.nom.label', default: 'Nom')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${POIInstanceList}" status="i" var="POIInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
					
						<td><g:link action="show" id="${POIInstance.id}">${fieldValue(bean: POIInstance, field: "nom")}</g:link></td>

						<sec:ifAnyGranted roles="ROLE_ADMINISTRATEUR,ROLE_MODERATEUR">
							<td><g:link controller="utilisateur" action="show" id="${POIInstance?.auteur?.id}">${fieldValue(bean: POIInstance, field: "auteur")}</g:link></td>
						</sec:ifAnyGranted>
						<sec:ifNotGranted roles="ROLE_ADMINISTRATEUR,ROLE_ADMINISTRATEUR">
							<td>${fieldValue(bean: POIInstance, field: "auteur")}</td>
						</sec:ifNotGranted>

					
						<td>${fieldValue(bean: POIInstance, field: "description")}</td>
					
						<td>${fieldValue(bean: POIInstance, field: "latitude")}</td>
					
						<td>${fieldValue(bean: POIInstance, field: "longitude")}</td>
					
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${POIInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
