package fr.mbds.tpgrails

class POI extends AbstractIllustrated implements Comparable<POI>{

    static constraints = {
    }

    static hasMany = [groupes: Groupe]
    static belongsTo = Groupe

    double latitude;
    double longitude;
    String description;
    //Set<Groupe> groupes;

    POI(String nom, double latitude, double longitude, String description) {
    	super(nom, new LinkedHashSet<Image>())
    	this.latitude = latitude;
    	this.longitude = longitude;
    }

    int compareTo(POI autre) {
    	return nom.compareTo(autre.nom)
    }

    public String toString() {
        return nom
    }
}
