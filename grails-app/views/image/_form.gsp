<%@ page import="fr.mbds.tpgrails.Image" %>



<div class="fieldcontain ${hasErrors(bean: imageInstance, field: 'chemin', 'error')} required">
	<label for="chemin">
		<g:message code="image.chemin.label" default="Chemin" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="chemin" required="" value="${imageInstance?.chemin}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: imageInstance, field: 'titre', 'error')} required">
	<label for="titre">
		<g:message code="image.titre.label" default="Titre" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="titre" required="" value="${imageInstance?.titre}"/>

</div>

