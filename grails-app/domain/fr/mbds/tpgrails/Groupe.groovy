package fr.mbds.tpgrails


class Groupe extends AbstractIllustrated {

    static constraints = {
    	pois nullable: true
    }

    static hasMany = [pois : POI]

    
    List pois;


}
