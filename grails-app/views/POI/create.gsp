<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'POI.label', default: 'POI')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
		<asset:stylesheet src="leaflet.css"/>
	</head>
	<body>
		<a href="#create-POI" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<sec:ifAnyGranted roles="ROLE_ADMINISTRATEUR,ROLE_MODERATEUR">
			<div id="create-POI" class="content scaffold-create" role="main">
				<h1><g:message code="default.create.label" args="[entityName]" /></h1>
				<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
				</g:if>
				<g:hasErrors bean="${POIInstance}">
				<ul class="errors" role="alert">
					<g:eachError bean="${POIInstance}" var="error">
					<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
					</g:eachError>
				</ul>
				</g:hasErrors>
				<g:uploadForm action="upload" url="[resource:POIInstance, action:'save']" method="POST">
					<fieldset class="form">
						<g:render template="form"/>
					</fieldset>
					<fieldset class="buttons">
						<g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" />
					</fieldset>
				</g:uploadForm>
				<div id="cartePOI" class="cartePOI"></div>
					<asset:javascript src="carte.js"/>
					<g:javascript >

						var lat = <g:formatNumber number="${POIInstance?.latitude}" maxFractionDigits="10"  locale="US"/>;
						var lng = <g:formatNumber number="${POIInstance?.longitude}" maxFractionDigits="10" locale="US" />;
						cartePOI(lat, lng, true, true);

					</g:javascript>
				</div>
		</sec:ifAnyGranted>
	</body>
</html>
