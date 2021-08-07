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
        List<Subscription> subscriptions = Subscription.findAllByTopic(topic)
        render(view: "viewTopic", model: [topic: topic,resources: resources, subscriptions: subscriptions])
    }

    def searchTopics(){
        List<Topic> detailedTopics = Topic.findAllByNameIlikeAndVisibility("${params.text}%", Visibility.Public)
        List<TopicDetailDTO> topics = []
        detailedTopics.each {
          if(Subscription.findByTopicAndSubscriber(it,session.user) != null){
                topics << new TopicDetailDTO(topicId: it.id, topicName: it.name, subsCount: it.subscriptions.size(), postCount: it.resources.size(), creatorId: it.createdBy.id, creatorPhoto: it.createdBy.photo, creatorUserName: it.createdBy.userName, isSubscribed: true)
            }else{
                topics << new TopicDetailDTO(topicId: it.id, topicName: it.name, subsCount: it.subscriptions.size(), postCount: it.resources.size(), creatorId: it.createdBy.id,creatorPhoto: it.createdBy.photo, creatorUserName: it.createdBy.userName, isSubscribed: false)
            }
        }

        render(topics as JSON)
    }

    def subscribeTopic(){
        Subscription subscription = topicService.subscribe(session.user, params.int("id"))

        redirect(uri: request.getHeader('referer'))
    }


    def unsubscribeTopic(){
        Subscription subscription = topicService.unsubscribe(session.user, params.int("id"))

        redirect(uri: request.getHeader('referer'))
    }

    def deleteTopic(int id){
        String msg = topicService.delete(session.user,id)

        render msg
    }
}
