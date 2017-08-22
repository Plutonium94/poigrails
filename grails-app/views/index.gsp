<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main"/>
		<title>Points d'Intérêt</title>
		<style type="text/css" media="screen">
			#status {
				background-color: #eee;
				border: .2em solid #fff;
				margin: 2em 2em 1em;
				padding: 1em;
				width: 12em;
				float: left;
				-moz-box-shadow: 0px 0px 1.25em #ccc;
				-webkit-box-shadow: 0px 0px 1.25em #ccc;
				box-shadow: 0px 0px 1.25em #ccc;
				-moz-border-radius: 0.6em;
				-webkit-border-radius: 0.6em;
				border-radius: 0.6em;
			}

			.ie6 #status {
				display: inline; /* float double margin fix http://www.positioniseverything.net/explorer/doubled-margin.html */
			}

			#status ul {
				font-size: 0.9em;
				list-style-type: none;
				margin-bottom: 0.6em;
				padding: 0;
			}

			#status li {
				line-height: 1.3;
			}

			#status h1 {
				text-transform: uppercase;
				font-size: 1.1em;
				margin: 0 0 0.3em;
			}

			#page-body {
				margin: 2em 1em 1.25em 18em;
			}

			h2 {
				margin-top: 1em;
				margin-bottom: 0.3em;
				font-size: 1em;
			}

			p {
				line-height: 1.5;
				margin: 0.25em 0;
			}

			#controller-list ul {
				list-style-position: inside;
			}

			#controller-list li {
				line-height: 1.3;
				list-style-position: inside;
				margin: 0.25em 0;
			}

			#currentUserModify {
				text-decoration: underline;
				cursor: pointer;
				color: #48802c;
			}

			@media screen and (max-width: 480px) {
				#status {
					display: none;
				}

				#page-body {
					margin: 0 1em 1em;
				}

				#page-body h1 {
					margin-top: 0;
				}
			}
		</style>
	</head>
	<body>
		<a href="#page-body" class="skip"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		
		<div id="page-body" role="main">
			<h1>Bienvenue <a id="currentUser"><sec:loggedInUserInfo field="username"/></a>, aux Points d'Intérêt</h1>
			<p>Vous découvrez sur ce site differents points d'intérêt dans les Alpes Maritimes (06).</p>

			<div id="controller-list" role="navigation">
				<ul>
					<li class="controller"><g:link controller="POI" action="index"> Les Points d'Intérêt</g:link></li>
					<li class="controller"><g:link controller="Groupe" action="index">Les Groupes</g:link></li>
					<sec:ifAnyGranted roles="ROLE_ADMINISTRATEUR,ROLE_MODERATEUR">
					<li class="controller"><g:link controller="Utilisateur" action="index">Les Utilisateurs</g:link></li>
					</sec:ifAnyGranted>
					
				</ul>
			</div>

			<p><a id="currentUserModify">Modifier votre profil</a></p>
		</div>
		<script>
			window.addEventListener('load', function() {
				var currentUserId = '<sec:loggedInUserInfo field="id"/>';
				var href='/${grails.util.Metadata.current.'app.name'}/utilisateur/edit/<sec:loggedInUserInfo field="id" />';
				document.getElementById('currentUserModify').setAttribute('href',href);
			});
		</script>
	</body>
</html>
