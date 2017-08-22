package fr.mbds.tpgrails


import grails.converters.JSON
import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import grails.plugin.springsecurity.annotation.Secured

@Transactional(readOnly = true)
@Secured(['ROLE_ADMINISTRATEUR','ROLE_MODERATEUR','ROLE_UTILISATEUR_NORMAL'])
class POIController {

    def imageUploadService

    static allowedMethods = [save: "POST", update: ["POST","PUT"], delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond POI.list(params), model:[POIInstanceCount: POI.count()]
    }

    def show(POI POIInstance) {
        respond POIInstance
    }

    @Secured(['ROLE_ADMINISTRATEUR','ROLE_MODERATEUR'])
    def create() {
        respond new POI(params)
    }

    @Transactional
    def save(POI POIInstance) {
        
        if (POIInstance == null) {
            notFound()
            return
        }

        if (POIInstance.hasErrors()) {
            respond POIInstance.errors, view:'create'
            return
        }

        imageUploadService.upload(POIInstance, request, params)

        POIInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'POI.label', default: 'POI'), POIInstance.id])
                redirect POIInstance
            }
            '*' { respond POIInstance, [status: CREATED] }
        }
    }

    @Secured(['ROLE_ADMINISTRATEUR','ROLE_MODERATEUR'])
    def edit(POI POIInstance) {
        respond POIInstance
    }

    @Transactional
    def update(POI POIInstance) {

        println("poi update called for " + POIInstance);
        println(params);
        println(params.latitude);
        if (POIInstance == null) {
            println("going to POIInstance not found")
            notFound()
            return
        }

        if (POIInstance.hasErrors()) {
            respond POIInstance.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                
                imageUploadService.upload(POIInstance,request, params)

                POIInstance.save flush:true
                flash.message = message(code: 'default.updated.message', args: [message(code: 'POI.label', default: 'POI'), POIInstance.id])
                redirect POIInstance
            }
            '*'{ 
                
                POIInstance.save flush:true
                respond POIInstance, [status: OK, formats:['json']]
            }
        }
    }

    @Secured(['ROLE_ADMINISTRATEUR','ROLE_MODERATEUR'])    
    @Transactional
    def updateCoordinates() {
        def errorMessage = "";
        def id = params.id as Long
        println(id)
        def p = POI.get(id)
        if(p != null) {
            p.latitude = params.latitude as Double
            p.longitude = params.longitude as Double

            
            if(p.save(flush:true)) {

                render ([latitude: p.latitude, longitude: p.longitude] as JSON)
                return
            } else {
                p.errors.each {
                    errorMessage += it
                }
            }

            
        } else {
            errorMessage = "Could not update coordinates since not matching POI with id " + params.id;
        }
        render([errorMessage]: errorMessage)
    }

    @Secured(['ROLE_ADMINISTRATEUR','ROLE_MODERATEUR'])    
    @Transactional
    def delete(POI POIInstance) {

        if (POIInstance == null) {
            notFound()
            return
        }

        POIInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'POI.label', default: 'POI'), POIInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'POI.label', default: 'POI'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
