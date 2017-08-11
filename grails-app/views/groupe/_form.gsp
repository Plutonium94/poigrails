<%@ page import="fr.mbds.tpgrails.Groupe" %>



<div class="fieldcontain ${hasErrors(bean: groupeInstance, field: 'images', 'error')} ">
	<label for="images">
		<g:message code="groupe.images.label" default="Images" />
		
	</label>
	<!--<g:select name="images" from="${fr.mbds.tpgrails.Image.list()}" multiple="multiple" optionKey="id" size="5" value="${groupeInstance?.images*.id}" class="many-to-many"/>-->
	<g:imgUpload name="imgName1" />

</div>

<div class="fieldcontain ${hasErrors(bean: groupeInstance, field: 'pois', 'error')} ">
	<label for="pois">
		<g:message code="groupe.pois.label" default="Pois" />
		
	</label>
	<!--<g:select name="pois" from="${fr.mbds.tpgrails.POI.list()}" multiple="multiple" optionKey="id" size="5" value="${groupeInstance?.pois*.id}" class="many-to-many"/>-->
	<div id="groupePoiTransferDiv">
		<div id="groupePoiListe">
			<g:each in="${groupeInstance?.pois}" var="p" status="i">
				<div class="poi" draggable="true" data-ligne="${i}" data-id="${p.id}">
					${p.nom}
					
				</div>
			</g:each>
		</div>

		<div id="poiListe">
			<g:each in="${POIInstanceList}" var="p" status="i">
				<div class="poi" draggable="true" data-id="${p.id}" data-ligne="${i}">
					<!--<g:link controller="POI" action="show" id="${p.id}">-->
						${p.nom}
					<!--</g:link>-->
				</div>
			</g:each>
		</div>
	</div>

</div>

<div class="fieldcontain ${hasErrors(bean: groupeInstance, field: 'auteur', 'error')} required">
	<label for="auteur">
		<g:message code="groupe.auteur.label" default="Auteur" />
		<span class="required-indicator">*</span>
	</label>
	<!--<g:select id="auteur" name="auteur.id" from="${fr.mbds.tpgrails.Utilisateur.list()}" optionKey="id" required="" value="${groupeInstance?.auteur?.id}" class="many-to-one"/>-->
	${groupeInstance?.auteur?.username}
	<input type="hidden" name="auteur.id" value="${groupeInstance?.auteur?.id}">

</div>

<div class="fieldcontain ${hasErrors(bean: groupeInstance, field: 'nom', 'error')} required">
	<label for="nom">
		<g:message code="groupe.nom.label" default="Nom" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="nom" required="" value="${groupeInstance?.nom}"/>

</div>

<div id="groupeMapDiv"></div>