import fr.mbds.tpgrails.*;

class BootStrap {

    def init = { servletContext ->

        def roleAdm = new fr.mbds.tpgrails.Role(authority: 'ROLE_ADMINISTRATEUR').save()
        def roleMod = new Role(authority:'ROLE_MODERATEUR').save()
        def roleNorm = new Role(authority:'ROLE_UTILISATEUR_NORMAL').save()

        def adm = new Utilisateur('CocaCola','CocaCola').save()
        UtilisateurRole.create(adm,roleAdm,true)

        def mod1 = new Utilisateur('Cherrry','Cherrry').save()
        def mod2 = new Utilisateur('Zero','Zero').save()
        UtilisateurRole.create(mod1,roleMod,true)
        UtilisateurRole.create(mod2,roleMod,true)

        def normUsr1 = new Utilisateur('Fanta','Fanta').save()
        def normUsr2 = new Utilisateur('Sprite','Sprite').save()
        def normUsr3 = new Utilisateur('Limca','Limca').save()
        
        for(Utilisateur u : [normUsr1,normUsr2,normUsr3] as Utilisateur[]) {
            UtilisateurRole.create(u, roleNorm, true)
        }

    	def kfcNice = new POI(nom: 'KFC Nice Jean Medecin',latitude:43.705236,longitude:7.265291, description:'KFC a du poulet frit croussillant',auteur: mod1)
        //mod1.addToCreations(kfcNice).save()
    	def quickAntibes = new POI(nom: 'Quick Antibes', latitude:43.599065, longitude:7.085514, description:'Quick a des bons burgers', auteur: mod2)
        //mod2.addToCreations(quickAntibes).save()
    	def fastFood = new Groupe(nom:'Fast Food', auteur:mod1 ).save(flush:true, failOnError:true)


        def ahaChina = new POI(nom: 'China Fast Food', latitude: 43.705145, longitude: 7.264828, description:'Specialites chinoises, thainlandais et singaporeens ', auteur: mod1)
        def miam = new POI(nom: 'Miam', latitude:43.704567,longitude:7.263262, description:'Specialites chinoises et thainlandais', auteur: mod2 )

        fastFood.addToPois(kfcNice).save(flush:true, failOnError:true)
        fastFood.addToPois(quickAntibes).save(flush:true, failOnError:true)
        fastFood.addToPois(ahaChina).save(flush:true, failOnError:true)
        fastFood.addToPois(miam).save(flush:true, failOnError:true)
        fastFood.save(flush:true, failOnError:true)
        //mod1.addToCreations(fastFood).save()

        def supermarches = new Groupe(nom:'Supermarches', auteur:mod1 ).save(flush:true, failOnError:true)        
        supermarches.addToPois(new POI(nom: 'Centre Commercial Carrefour Antibes',latitude:43.603938, longitude:7.089346,description:'Grand Centre Commercial avec Carrefour Hypermarche a Antibes',auteur: mod1))
        supermarches.addToPois(new POI(nom: 'Casino Supermarche Saint Philippe', latitude: 43.617918, longitude:7.075252, description:'Un supermarche à la Place de Saint Philippe a Sophia', auteur: mod1))
        supermarches.addToPois(new POI(nom: 'Carrefour Market Valbonne',latitude: 43.645859, longitude: 7.049191, description:'Un supermarche au Valbonne Village', auteur:mod2))
        supermarches.addToPois(new POI(nom: 'Carrefour Nice TNL', latitude: 43.706654, longitude:7.286477, description:'Un supermarche dans un centre commerical a Nice Centre',auteur:mod1))
        supermarches.addToPois(new POI(nom: 'Casino supermarche et drive',latitude : 43.674871,longitude: 7.226165, description:'Un supermarche a Nice Ouest dans la Promenade des Anglais', auteur: mod1))
        supermarches.save(flush:true, failOnError:true)

        def gares = new Groupe(nom: 'Gares de Transport', auteur:mod2).save(flush:true,failOnError:true)
        gares.addToPois(new POI(nom: 'Gare d Antibes', latitude : 43.585806, longitude: 7.119456, description: 'La Gare SNCF d Antibes', auteur:mod1))
        gares.addToPois(new POI(nom: 'Gare de Juan les Pins',latitude : 43.570893,longitude :7.111603, description:'La Gare SNCF de Juan les Pins',auteur:mod2))
        gares.addToPois(new POI(nom: 'Gare de Nice-Ville', latitude: 43.704617, longitude: 7.261975, description: 'La Gare SNCF de Nice Ville', auteur: mod2))
        gares.addToPois(new POI(nom: 'Gare Routière Valbonne Sophia Antipolis',latitude : 43.624015,longitude: 7.037137, description: 'La Gare Routiere de Sophia Antipolis', auteur: mod2))
        gares.addToPois(new POI(nom: 'Gare Routière d Antibes', latitude: 43.580277, longitude:7.122360, description: 'La Gare Routiere d Antibes', auteur: mod1))
        gares.save(flush:true, failOnError:true)
    }
    def destroy = {
    }
}
