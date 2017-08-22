


Installation : 
Version de Grails : 2.5.5
Installer MySQL avec une BD qui s'appelle "vic"
Config.groovy : mettre des chemins et urls corrects pour images.pois.path, images.pois.url, images.groupes.path, images.groupes.url
Datasource.groovy : vérifier environments -> development -> datasource -> url (changer nom de BD si besoin)

Exécution :
grails run-app

Utilisateurs (login/mot_de_passe)
Admin : CocaCola/CocaCola
Moderateur : Zero/Zero
Normal : Fanta/Fanta

Implémentation Parties Bonus :
* Création initiale d'entités : InitializePoiAppService.groovy
* Upload d'images pour groups et pois : ImageUploadService.groovy, views/balises/_imgUpload.gsp
* Drag & Drop pour réordonner et migrer des pois dans un groupe : views/groupe/edit.gsp
* Map pour Groupes : views/groupe/show.gsp
* Maps pour POIs (Modif des coordonnées) : views/poi/edit.gsp, assets/javascripts/carte.js, POIController -> updateCoordinates()




