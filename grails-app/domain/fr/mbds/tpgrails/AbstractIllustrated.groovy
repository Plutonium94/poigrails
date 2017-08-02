package fr.mbds.tpgrails

class AbstractIllustrated {

    static constraints = {
    	images nullable:true
    	nom unique:true
    }

    static hasMany = [images :Image]

    String nom;
    Utilisateur auteur;

    public String toString() {
    	return nom;
    }
    

}
