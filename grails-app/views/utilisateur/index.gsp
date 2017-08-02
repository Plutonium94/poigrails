
<%@ page import="fr.mbds.tpgrails.Utilisateur" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'utilisateur.label', default: 'Utilisateur')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-utilisateur" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<sec:ifAnyGranted roles="ROLE_ADMINISTRATEUR">
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
				</sec:ifAnyGranted>
			</ul>
		</div>
		<div id="list-utilisateur" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="username" title="${message(code: 'utilisateur.username.label', default: 'Username')}" />
					
						%{--<g:sortableColumn property="password" title="${message(code: 'utilisateur.password.label', default: 'Password')}" />--}%
					
						<g:sortableColumn property="accountExpired" title="${message(code: 'utilisateur.accountExpired.label', default: 'Account Expired')}" />
					
						<g:sortableColumn property="accountLocked" title="${message(code: 'utilisateur.accountLocked.label', default: 'Account Locked')}" />
					
						<g:sortableColumn property="enabled" title="${message(code: 'utilisateur.enabled.label', default: 'Enabled')}" />
					
						<g:sortableColumn property="passwordExpired" title="${message(code: 'utilisateur.passwordExpired.label', default: 'Password Expired')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${utilisateurInstanceList}" status="i" var="utilisateurInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td>
							<g:link action="show" id="${utilisateurInstance.id}">${fieldValue(bean: utilisateurInstance, field: "username")}</g:link>
						</td>
					
						%{--<td>${fieldValue(bean: utilisateurInstance, field: "password")}</td>--}%
					
						<td><g:formatBoolean boolean="${utilisateurInstance.accountExpired}" /></td>
					
						<td><g:formatBoolean boolean="${utilisateurInstance.accountLocked}" /></td>
					
						<td><g:formatBoolean boolean="${utilisateurInstance.enabled}" /></td>
					
						<td><g:formatBoolean boolean="${utilisateurInstance.passwordExpired}" /></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${utilisateurInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
