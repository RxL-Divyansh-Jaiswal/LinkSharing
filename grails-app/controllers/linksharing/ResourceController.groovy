package linksharing

import grails.converters.JSON

class ResourceController {

    def topicService
    def resourceService

    def index() { }

    def viewResource(){
        Resource resource = Resource.findById(params.id)
        List trendingTopics = topicService.trending(session.user)
        Map<String,String> months = ["01":"Jan","02":"Feb","03":"Mar","04":"Apr","05":"May","06":"Jun","07":"Jul","08":"Aug","09":"Sep","10":"Oct","11":"Nov","12":"Dec"]
        Map<String,String> hours = ["00":"AM","01":"AM","02":"AM","03":"AM","04":"AM","05":"AM","06":"AM","07":"AM","08":"AM","09":"AM","10":"AM","11":"AM","12":"PM","13":"PM","14":"PM","15":"PM","16":"PM","17":"PM","18":"PM","19":"PM","20":"PM","21":"PM","22":"PM","23":"PM"]
        render(view: "viewResource", model: [resource:resource, monthMap: months, hourMap: hours, trendingTopics: trendingTopics])
    }

    def download(){
        DocumentResource resource = Resource.findById(params.id)
        String pathToFile = resource.filePath
        println "Path to file----------->" + pathToFile
        String extension = resource.filePath.split("\\.")[-1]
        println "Extension-------------->" + extension

        def file = new File(pathToFile)

        response.setContentType(extension)
        response.setHeader("Content-disposition", "filename=${resource.name}")
        response.outputStream << file.bytes
        println "File downloaded.............."
        return
    }

    def markRead(){
        String msg = resourceService.read(session.user,params.int("id"))
        println "---------->" + msg

//        redirect(uri: request.getHeader('referer'))
        List<String> list = []
        list << msg
        render(list as JSON)
    }

    def rateResource(){
        String msg = resourceService.rate(session.user,params.int("id"),params.int("score"))
        println "---------->" + msg

        List<String> list = []
        list << msg
        render(list as JSON)
    }
}
