<%@ page import="fr.mbds.tpgrails.AbstractIllustrated" %>



<div class="fieldcontain ${hasErrors(bean: abstractIllustratedInstance, field: 'images', 'error')} ">
	<label for="images">
		<g:message code="abstractIllustrated.images.label" default="Images" />
		
	</label>
	<g:select name="images" from="${fr.mbds.tpgrails.Image.list()}" multiple="multiple" optionKey="id" size="5" value="${abstractIllustratedInstance?.images*.id}" class="many-to-many"/>

</div>

<div class="fieldcontain ${hasErrors(bean: abstractIllustratedInstance, field: 'auteur', 'error')} required">
	<label for="auteur">
		<g:message code="abstractIllustrated.auteur.label" default="Auteur" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="auteur" name="auteur.id" from="${fr.mbds.tpgrails.Utilisateur.list()}" optionKey="id" required="" value="${abstractIllustratedInstance?.auteur?.id}" class="many-to-one"/>

</div>

<div class="fieldcontain ${hasErrors(bean: abstractIllustratedInstance, field: 'nom', 'error')} required">
	<label for="nom">
		<g:message code="abstractIllustrated.nom.label" default="Nom" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="nom" required="" value="${abstractIllustratedInstance?.nom}"/>

</div>

