<%@ page import="fr.mbds.tpgrails.Utilisateur" %>



<div class="fieldcontain ${hasErrors(bean: utilisateurInstance, field: 'username', 'error')} required">
	<label for="username">
		<g:message code="utilisateur.username.label" default="Username" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="username" required="" value="${utilisateurInstance?.username}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: utilisateurInstance, field: 'password', 'error')} required">
	<label for="password">
		<g:message code="utilisateur.password.label" default="Password" />
		<span class="required-indicator">*</span>
	</label>
	%{--<g:textField name="password" required="" value="${utilisateurInstance?.password}"/>--}%
	<g:passwordField name="password" required="" value="${utilisateurInstance?.password}" />

</div>

<div class="fieldcontain ${hasErrors(bean: utilisateurInstance, field: 'accountExpired', 'error')} ">
	<label for="accountExpired">
		<g:message code="utilisateur.accountExpired.label" default="Account Expired" />
		
	</label>
	<g:checkBox name="accountExpired" value="${utilisateurInstance?.accountExpired}" />

</div>

<div class="fieldcontain ${hasErrors(bean: utilisateurInstance, field: 'accountLocked', 'error')} ">
	<label for="accountLocked">
		<g:message code="utilisateur.accountLocked.label" default="Account Locked" />
		
	</label>
	<g:checkBox name="accountLocked" value="${utilisateurInstance?.accountLocked}" />

</div>

<div class="fieldcontain ${hasErrors(bean: utilisateurInstance, field: 'enabled', 'error')} ">
	<label for="enabled">
		<g:message code="utilisateur.enabled.label" default="Enabled" />
		
	</label>
	<g:checkBox name="enabled" value="${utilisateurInstance?.enabled}" />

</div>

<div class="fieldcontain ${hasErrors(bean: utilisateurInstance, field: 'passwordExpired', 'error')} ">
	<label for="passwordExpired">
		<g:message code="utilisateur.passwordExpired.label" default="Password Expired" />
		
	</label>
	<g:checkBox name="passwordExpired" value="${utilisateurInstance?.passwordExpired}" />

</div>

