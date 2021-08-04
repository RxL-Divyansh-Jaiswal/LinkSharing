package linksharing

import dto.TopicDetailDTO
import grails.converters.JSON
import linksharing.enums.Visibility

class TopicController {

    def topicService

    def index() { }

    def createTopic(){
        String msg = topicService.create(session.user,params)

        if(msg.split(" ").last() == "Successfully"){
            flash.topicSuccess = msg
        }else{
            flash.topicError = msg
        }

        redirect(uri: request.getHeader('referer'))
    }

    def addLinkResource(){
        String msg = topicService.linkResource(session.user,params)

        if(msg.split(" ")[0] == "Link"){
            flash.linkResSuccess = msg
        }else{
            flash.linkResError = msg
        }

        redirect(uri: request.getHeader('referer'))
    }

    def addDocResource(){
        String msg = topicService.docResource(session.user,params,request)

        if(msg.split(" ")[0] == "Document"){
            flash.docResSuccess = msg
        }else{
            flash.docResError = msg
        }

        redirect(uri: request.getHeader('referer'))
    }

    def viewTopic(){
        Topic topic = Topic.findById(params.id)
        List<Resource> resources = Resource.findAllByTopic(topic)
        render(view: "viewTopic", model: [topic: topic,resources: resources])
    }

    def searchTopics(){
        List<Topic> detailedTopics = Topic.findAllByNameIlikeAndVisibility("${params.text}%", Visibility.Public)
        List<TopicDetailDTO> topics = []
        detailedTopics.each {
            topics << new TopicDetailDTO(topicId: it.id, topicName: it.name, creatorPhoto: it.createdBy.photo, creatorUserName: it.createdBy.userName)
        }

        render(topics as JSON)
    }

    def deleteTopic(int id){
        String msg = topicService.delete(session.user,id)

        render msg
    }
}
