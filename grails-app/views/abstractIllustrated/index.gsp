
<%@ page import="fr.mbds.tpgrails.AbstractIllustrated" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'abstractIllustrated.label', default: 'AbstractIllustrated')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-abstractIllustrated" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-abstractIllustrated" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<th><g:message code="abstractIllustrated.auteur.label" default="Auteur" /></th>
					
						<g:sortableColumn property="nom" title="${message(code: 'abstractIllustrated.nom.label', default: 'Nom')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${abstractIllustratedInstanceList}" status="i" var="abstractIllustratedInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${abstractIllustratedInstance.id}">${fieldValue(bean: abstractIllustratedInstance, field: "auteur")}</g:link></td>
					
						<td>${fieldValue(bean: abstractIllustratedInstance, field: "nom")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${abstractIllustratedInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
