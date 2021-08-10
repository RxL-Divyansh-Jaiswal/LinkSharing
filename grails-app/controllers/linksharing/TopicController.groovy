package linksharing

import dto.TopicDetailDTO
import grails.converters.JSON
import linksharing.enums.Seriousness
import linksharing.enums.Visibility

class TopicController {

    def topicService // topic service

    def index() { }

//  creating new topic
    def createTopic(){
        String msg = topicService.create(session.user,params) // calling create topic service

//      redirecting according to response
        if(msg.split(" ").last() == "Successfully"){
            flash.topicSuccess = msg
        }else{
            flash.topicError = msg
        }
        redirect(uri: request.getHeader('referer'))
    }

//  creating link resource
    def addLinkResource(){
        String msg = topicService.linkResource(session.user,params) // calling link resource service

//      redirecting according to response
        if(msg.split(" ")[0] == "Link"){
            flash.linkResSuccess = msg
        }else{
            flash.linkResError = msg
        }
        redirect(uri: request.getHeader('referer'))
    }

//  creating a doc resource
    def addDocResource(){
        String msg = topicService.docResource(session.user,params,request) // caling doc resource service

//      redirecting according to response
        if(msg.split(" ")[0] == "Document"){
            flash.docResSuccess = msg
        }else{
            flash.docResError = msg
        }
        redirect(uri: request.getHeader('referer'))
    }

//  view a topic
    def viewTopic(){
        Topic topic = Topic.findById(params.id) // finding topic by id
        List<Resource> resources = Resource.findAllByTopic(topic) // all resources of the topic
        List<Subscription> subscriptions = Subscription.findAllByTopic(topic) // all subscriptions of topic
        render(view: "viewTopic", model: [topic: topic,resources: resources, subscriptions: subscriptions])
    }

//  search topics
    def searchTopics(){
        List<Topic> detailedTopics = Topic.findAllByNameIlikeAndVisibility("${params.text}%", Visibility.Public) // calling search service
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

//  subscribe a topic
    def subscribeTopic(){
        Subscription subscription = topicService.subscribe(session.user, params.int("id")) // calling subscribe service
        redirect(uri: request.getHeader('referer'))
    }

//  unsubscribe a topic
    def unsubscribeTopic(){
        Subscription subscription = topicService.unsubscribe(session.user, params.int("id")) // calling unsubscribe service
        redirect(uri: request.getHeader('referer'))
    }

//  change visibility of a topic
    def changeVisibility(){
        println params
        String msg = topicService.visibility(params.int("topic_id"),params.new_visibility) // calling visibility service
        List list = []
        list << msg
        render(list as JSON)
    }

//  change seriousness of a subscription
    def changeSeriousness(){
        println params
        String msg = topicService.seriousness(params.int("subs_id"),params.new_seriousness) // calling seriousness service
        List list = []
        list << msg
        render(list as JSON)
    }

//  send invite
    def sendInvite(){
        String msg = topicService.invite(params.email, params.topic) // calling invite service

        if(msg.split(" ")[0] == "Invited"){
            flash.inviteSuccess = msg
        }else{
            flash.inviteError = msg
        }
        redirect(uri: request.getHeader('referer'))
    }

//  delete a topic
    def deleteTopic(int id){
        String msg = topicService.delete(session.user,id) // calling delete service

//      redirecting according to response
        flash.topicDelSuccess = msg
        redirect(controller: "user", action: "dashboard")
    }
}
