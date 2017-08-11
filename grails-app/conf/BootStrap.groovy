import fr.mbds.tpgrails.*;

class BootStrap {

    def initializePoiAppService

    def init = { servletContext ->

        initializePoiAppService.initializeEntities()
        
    }
    
    def destroy = {
    }
}
