package linksharing

import dto.PostDetailsDTO
import grails.converters.JSON

class ResourceController {

    def topicService
    def resourceService

    def index() { }

//  view a resource
    def viewResource(){
        if(!session.user){
            redirect url: "/"
        }else {
            Resource resource = Resource.findById(params.id) // find the resource
            List trendingTopics = topicService.trending(session.user) // trending topics
//      maps for formatting date and time in gsp
            Map<String, String> months = ["01": "Jan", "02": "Feb", "03": "Mar", "04": "Apr", "05": "May", "06": "Jun", "07": "Jul", "08": "Aug", "09": "Sep", "10": "Oct", "11": "Nov", "12": "Dec"]
            Map<String, String> hours = ["00": "AM", "01": "AM", "02": "AM", "03": "AM", "04": "AM", "05": "AM", "06": "AM", "07": "AM", "08": "AM", "09": "AM", "10": "AM", "11": "AM", "12": "PM", "13": "PM", "14": "PM", "15": "PM", "16": "PM", "17": "PM", "18": "PM", "19": "PM", "20": "PM", "21": "PM", "22": "PM", "23": "PM"]
            render(view: "viewResource", model: [resource: resource, monthMap: months, hourMap: hours, trendingTopics: trendingTopics])
        }
    }

//  download a resource
    def download(int id){
        DocumentResource resource = Resource.findById(id) // find resource
        String pathToFile = resource.filePath // file path in dir str
        String extension = resource.filePath.split("\\.")[-1] // extension of file

        def file = new File(pathToFile)

        response.setContentType(extension)
        response.setHeader("Content-disposition", "filename=${resource.name}")
        response.outputStream << file.bytes
        return
    }

//  mark a resource reading item from a resource as read
    def markRead(int id){
        String msg = resourceService.read(session.user,id) // calling read service

        List<String> list = []
        list << msg
        render(list as JSON)
    }

//  rate a resource
    def rateResource(int id, int score){
        String msg = resourceService.rate(session.user,id,score) // calling rate service

        List<String> list = []
        list << msg
        render(list as JSON)
    }

//  delete a resource
    def deleteResource(int id){
        String msg = resourceService.delete(id) // calling delete service

//      redirecting according to response
        flash.success = msg
        redirect(controller: "user", action: "dashboard")
    }

//  recent shares
    def recentShares(){
        List<Resource> resources = Resource.all // all resources
        List<PostDetailsDTO> list = []

        resources.each {
            def duration = groovy.time.TimeCategory.minus(new Date(), it.dateCreated) // finding difference in time
            list << new PostDetailsDTO(creatorPhoto: it.createdBy.photo,creatorName: it.createdBy.name, creatorUserName: it.createdBy.userName, topicName: it.topic.name, description: it.description, minsPassed: duration.minutes)
        }

        list.sort({ a, b -> a.minsPassed == b.minsPassed ? 0 : a.minsPassed < b.minsPassed ? -1 : 1 }) // sorting the list based on minutes elapsed
        render(list as JSON)
    }

//  top posts
    def topPosts(){
        List posts = resourceService.top() // calling top post service
        List<PostDetailsDTO> list = []

        posts.each{
            def duration = groovy.time.TimeCategory.minus(new Date(), it[1].dateCreated) // finding difference in time
            list << new PostDetailsDTO(creatorPhoto: it[1].createdBy.photo,creatorName: it[1].createdBy.name, creatorUserName: it[1].createdBy.userName, topicName: it[1].topic.name, description: it[1].description, minsPassed: duration.minutes)
        }
        render(list as JSON)
    }
}
