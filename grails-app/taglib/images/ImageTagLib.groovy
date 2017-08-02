package images

class ImageTagLib {
    

    def imgUpload = {
    	attrs,
    	body ->		
    		out<< render(template: "/balises/imgUpload")
    }
}
