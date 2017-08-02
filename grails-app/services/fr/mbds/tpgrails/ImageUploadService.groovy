package fr.mbds.tpgrails

import grails.transaction.Transactional

@Transactional
class ImageUploadService {

    def grailsApplication

    def upload(AbstractIllustrated poi,request, params ) {
        println("appele");
        int imgCpt = 1;
        String cheminSauvegarde = '';
        if(poi instanceof POI) {
            cheminSauvegarde = grailsApplication.config.images.pois.path;
        } else if(poi instanceof Groupe) {
            cheminSauvegarde = grailsApplication.config.images.groupes.path;
        }
        println(cheminSauvegarde);
        while(true) {
            def f = request.getFile("image"+imgCpt)
            if(f == null) {
                println("f null")
                break
            } else if(f.empty) {
                println("file " + imgCpt + " vide")
                break
            } else {
                def fileName = createFileName(poi.id)
                f.transferTo(new File(cheminSauvegarde+fileName))
                def im = new Image(chemin:fileName, titre: params["image"+imgCpt+"Title"] + imgCpt)
                poi.addToImages(im)
                imgCpt++
            }
            
        }
    }



    def createFileName(id) {
        return id + "__" + System.currentTimeMillis();
    }
}