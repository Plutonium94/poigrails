<%@ page import="fr.mbds.tpgrails.POI" %>



<div class="fieldcontain ${hasErrors(bean: POIInstance, field: 'images', 'error')} ">
	<label for="images">
		<g:message code="POI.images.label" default="Images" />
		
	</label>
	<!--<g:select name="images" from="${fr.mbds.tpgrails.Image.list()}" multiple="multiple" optionKey="id" size="5" value="${POIInstance?.images*.id}" class="many-to-many"/>-->

	<g:imgUpload name="imgName1" />

</div>

<div class="fieldcontain ${hasErrors(bean: POIInstance, field: 'auteur', 'error')} required">
	<label for="auteur">
		<g:message code="POI.auteur.label" default="Auteur" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="auteur" name="auteur.id" from="${fr.mbds.tpgrails.Utilisateur.list()}" optionKey="id" required="" value="${POIInstance?.auteur?.id}" class="many-to-one"/>

	

</div>

<div class="fieldcontain ${hasErrors(bean: POIInstance, field: 'description', 'error')} required">
	<label for="description">
		<g:message code="POI.description.label" default="Description" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="description" required="" value="${POIInstance?.description}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: POIInstance, field: 'groupes', 'error')} ">
	<label for="groupes">
		<g:message code="POI.groupes.label" default="Groupes" />
		
	</label>
	

</div>

<div class="fieldcontain ${hasErrors(bean: POIInstance, field: 'latitude', 'error')} required">
	<label for="latitude">
		<g:message code="POI.latitude.label" default="Latitude" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="latitude" value="${fieldValue(bean: POIInstance, field: 'latitude')}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: POIInstance, field: 'longitude', 'error')} required">
	<label for="longitude">
		<g:message code="POI.longitude.label" default="Longitude" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="longitude" value="${fieldValue(bean: POIInstance, field: 'longitude')}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: POIInstance, field: 'nom', 'error')} required">
	<label for="nom">
		<g:message code="POI.nom.label" default="Nom" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="nom" required="" value="${POIInstance?.nom}"/>

</div>

