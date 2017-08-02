package fr.mbds.tpgrails



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import grails.plugin.springsecurity.annotation.Secured


/* Peut un moderateur voir des profils, editer son propre profil, sachant que les normaux peuvent modifier leurs ? */
/* La listing d'utilisateurs : qui peuvent les consulter et en quel mesure */
@Transactional(readOnly = true)
@Secured(['ROLE_ADMINISTRATEUR','ROLE_MODERATEUR'])
class UtilisateurController {

    def springSecurityService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    @Secured(['ROLE_ADMINISTRATEUR','ROLE_MODERATEUR'])
    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Utilisateur.list(params), model:[utilisateurInstanceCount: Utilisateur.count()]
    }

    @Secured(['ROLE_MODERATEUR','ROLE_ADMINISTRATEUR','ROLE_UTILISATEUR_NORMAL'])
    def show(Utilisateur utilisateurInstance) {
        def currentUtilisateur = springSecurityService.getCurrentUser()
        def resNormal = (utilisateurInstance.authorities.any {it.authority == "ROLE_UTILISATEUR_NORMAL"})
        def sameUtilisateur = (currentUtilisateur == utilisateurInstance.id)
        if(request.isUserInRole("ROLE_UTILISATEUR_NORMAL") ) {
            if(utilisateurInstance.id == currentUtilisateur.id) {
                respond utilisateurInstance, [model: [normal: resNormal, idem: sameUtilisateur]]
            } else {
                redirect(controller:'login', action:'denied')
            }
        } else if(request.isUserInRole("ROLE_MODERATEUR")) {
            if(utilisateurInstance.authorities.any { it.authority == "ROLE_UTILISATEUR_NORMAL" } || utilisateurInstance.id == currentUtilisateur.id) {
                respond utilisateurInstance, [model: [normal: resNormal, idem: sameUtilisateur]]
            } else {
                redirect(controller:'login', action:'denied')
            }
        } else {

            respond utilisateurInstance, [model: [normal: resNormal, idem: sameUtilisateur]]
        }
    }

    def create() {
        respond new Utilisateur(params)
    }

    @Transactional
    def save(Utilisateur utilisateurInstance) {
        if (utilisateurInstance == null) {
            notFound()
            return
        }

        if (utilisateurInstance.hasErrors()) {
            respond utilisateurInstance.errors, view:'create'
            return
        }

        utilisateurInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'utilisateur.label', default: 'Utilisateur'), utilisateurInstance.id])
                redirect utilisateurInstance
            }
            '*' { respond utilisateurInstance, [status: CREATED] }
        }
    }

    @Secured(['ROLE_MODERATEUR','ROLE_ADMINISTRATEUR','ROLE_UTILISATEUR_NORMAL'])
    def edit(Utilisateur utilisateurInstance) {
        if(request.isUserInRole("ROLE_UTILISATEUR_NORMAL")) {
            if(utilisateurInstance.id == springSecurityService.getCurrentUser().id) {
                respond utilisateurInstance
            } else {
                redirect(controller:'login',action:'denied')
            }
        } else if(request.isUserInRole("ROLE_MODERATEUR") ) {
            def currentUtilisateur = springSecurityService.getCurrentUser()
            if(utilisateurInstance.id == currentUtilisateur.id) {
                respond utilisateurInstance
            } else if(utilisateurInstance.authorities.any { it.authority == 'ROLE_UTILISATEUR_NORMAL'}) {
                respond utilisateurInstance
            } else {
                redirect(controller:'login',action:'denied')
            }
        }
        respond utilisateurInstance
    }

    @Transactional
    def update(Utilisateur utilisateurInstance) {
        if (utilisateurInstance == null) {
            notFound()
            return
        }

        if (utilisateurInstance.hasErrors()) {
            respond utilisateurInstance.errors, view:'edit'
            return
        }

        utilisateurInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Utilisateur.label', default: 'Utilisateur'), utilisateurInstance.id])
                redirect utilisateurInstance
            }
            '*'{ respond utilisateurInstance, [status: OK] }
        }
    }

    @Secured(['ROLE_ADMINISTRATEUR'])
    @Transactional
    def delete(Utilisateur utilisateurInstance) {

        if (utilisateurInstance == null) {
            notFound()
            return
        }

        utilisateurInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Utilisateur.label', default: 'Utilisateur'), utilisateurInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'utilisateur.label', default: 'Utilisateur'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
