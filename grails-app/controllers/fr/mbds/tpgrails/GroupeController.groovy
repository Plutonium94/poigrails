package fr.mbds.tpgrails



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import grails.plugin.springsecurity.annotation.Secured

@Transactional(readOnly = true)
class GroupeController {

    def springSecurityService
    def imageUploadService


    static allowedMethods = [save: "POST", update:[ "PUT", "POST"], delete: "DELETE"]

    @Secured(['ROLE_ADMINISTRATEUR','ROLE_MODERATEUR','ROLE_UTILISATEUR_NORMAL'])
    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Groupe.list(params), model:[groupeInstanceCount: Groupe.count()]
    }

    @Secured(['ROLE_ADMINISTRATEUR','ROLE_MODERATEUR','ROLE_UTILISATEUR_NORMAL'])
    def show(Groupe groupeInstance) {
        respond groupeInstance
    }

    @Secured(['ROLE_ADMINISTRATEUR','ROLE_MODERATEUR'])
    def create() {
        if(params.auteur == null) {
            params.auteur = springSecurityService.currentUser
        }
        respond new Groupe(params)
    }

    @Secured(['ROLE_ADMINISTRATEUR','ROLE_MODERATEUR'])
    @Transactional
    def save(Groupe groupeInstance) {
        if (groupeInstance == null) {
            notFound()
            return
        }

        if (groupeInstance.hasErrors()) {
            respond groupeInstance.errors, view:'create'
            return
        }

        imageUploadService.upload(groupeInstance, request, params)

        groupeInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'groupe.label', default: 'Groupe'), groupeInstance.id])
                redirect groupeInstance
            }
            '*' { respond groupeInstance, [status: CREATED] }
        }
    }

    @Secured(['ROLE_ADMINISTRATEUR','ROLE_MODERATEUR'])
    def edit(Groupe groupeInstance) {
        respond groupeInstance, model: [POIInstanceList: POI.list(params)]
    }

    @Secured(['ROLE_ADMINISTRATEUR','ROLE_MODERATEUR'])
    @Transactional
    def update(Groupe groupeInstance) {
        println('update recu');
        println(params);
        if (groupeInstance == null) {
            notFound()
            return
        }

        if (groupeInstance.hasErrors()) {
            respond groupeInstance.errors, view:'edit'
            return
        }


        request.withFormat {
            form multipartForm {
                imageUploadService.upload(groupeInstance, request, params)
                groupeInstance.save flush:true
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Groupe.label', default: 'Groupe'), groupeInstance.id])
                redirect groupeInstance
            }
            '*'{
                groupeInstance.save flush:true 
                println("good reponse given")
                respond groupeInstance, [status: OK, formats:['json']] 
            }
        }
    }


    @Secured(['ROLE_ADMINISTRATEUR','ROLE_MODERATEUR'])
    @Transactional
    def delete(Groupe groupeInstance) {

        if (groupeInstance == null) {
            notFound()
            return
        }

        groupeInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Groupe.label', default: 'Groupe'), groupeInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    @Secured(['ROLE_ADMINISTRATEUR','ROLE_MODERATEUR','ROLE_UTILISATEUR_NORMAL'])
    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'groupe.label', default: 'Groupe'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
