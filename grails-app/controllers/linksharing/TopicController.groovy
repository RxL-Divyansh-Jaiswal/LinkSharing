package linksharing

import dto.TopicDetailDTO
import grails.converters.JSON
import linksharing.enums.Seriousness
import linksharing.enums.Visibility
import org.springframework.web.multipart.MultipartFile

class TopicController {

    def topicService // topic service

    def index() { }

//  creating new topic
    def createTopic(String name, String visibility){
        Map response = topicService.create(session.user,name,visibility) // calling create topic service

        if(response.topic){
            flash.success = response.msg
        }else{
            flash.error = response.msg
        }
        redirect(uri: request.getHeader('referer'))
    }

//  creating link resource
    def addLinkResource(String topic, String description, String url){
        Map response = topicService.linkResource(session.user,topic,description,url) // calling link resource service

        if(response.resource){
            flash.success = response.msg
        }else{
            flash.error = response.msg
        }
        redirect(uri: request.getHeader('referer'))
    }

//  creating a doc resource
    def addDocResource(String topic, String description, def request){
        MultipartFile doc = request.getFile("doc")
        Map response = topicService.docResource(session.user,topic,description,doc) // calling doc resource service

        if(response.resource){
            flash.success = response.msg
        }else{
            flash.error = response.msg
        }
        redirect(uri: request.getHeader('referer'))
    }

//  view a topic
    def viewTopic(){
        if(!session.user){
            redirect url: "/"
        }else {
            Topic topic = Topic.findById(params.id) // finding topic by id
            List<Resource> resources = Resource.findAllByTopic(topic) // all resources of the topic
            List<Subscription> subscriptions = Subscription.findAllByTopic(topic) // all subscriptions of topic
            render(view: "viewTopic", model: [topic: topic, resources: resources, subscriptions: subscriptions])
        }
    }

//  search topics
    def searchTopics(String text){
        if((session.user.admin && text == "") || text != ""){
            List<Topic> detailedTopics = topicService.search(text) // calling search service
            List<TopicDetailDTO> topics = []

            detailedTopics.each {
                if(Subscription.findByTopicAndSubscriber(it,session.user) != null){
                    topics << new TopicDetailDTO(topicId: it.id, topicName: it.name, subsCount: it.subscriptions.size(), postCount: it.resources.size(), creatorId: it.createdBy.id, creatorPhoto: it.createdBy.photo, creatorUserName: it.createdBy.userName, isSubscribed: true)
                }else{
                    topics << new TopicDetailDTO(topicId: it.id, topicName: it.name, subsCount: it.subscriptions.size(), postCount: it.resources.size(), creatorId: it.createdBy.id,creatorPhoto: it.createdBy.photo, creatorUserName: it.createdBy.userName, isSubscribed: false)
                }
            }
            render(topics as JSON)
        }else{
            List list = []
            render(list as JSON)
        }
    }

//  subscribe a topic
    def subscribeTopic(){
        Subscription response = topicService.subscribe(session.user, params.int("id")) // calling subscribe service
        redirect(uri: request.getHeader('referer'))
    }

//  unsubscribe a topic
    def unsubscribeTopic(){
        Subscription response = topicService.unsubscribe(session.user, params.int("id")) // calling unsubscribe service
        redirect(uri: request.getHeader('referer'))
    }

//  change visibility of a topic
    def changeVisibility(int topic_id, String new_visibility){
        String msg = topicService.visibility(topic_id,new_visibility) // calling visibility service
        List list = []
        list << msg
        render(list as JSON)
    }

//  change seriousness of a subscription
    def changeSeriousness(int subs_id, String new_seriousness){
        String msg = topicService.seriousness(subs_id,new_seriousness) // calling seriousness service
        List list = []
        list << msg
        render(list as JSON)
    }

//  send invite
    def sendInvite(String email, String topic){
        Map response = topicService.invite(email, topic) // calling invite service

        if(response.subscription){
            flash.success = response.msg
        }else{
            flash.error = response.msg
        }
        redirect(uri: request.getHeader('referer'))
    }

//  update name of an existing topic
    def updateName(int topic_id,String new_name){
        String msg = topicService.update(topic_id,new_name)

        List list = []
        list << msg
        render(list as JSON)
    }

//  delete a topic
    def deleteTopic(int id){
        if(!session.user){
            redirect url: "/"
        }else {
            String msg = topicService.delete(id) // calling delete service

//      redirecting according to response
            flash.success = msg
            redirect(controller: "user", action: "dashboard")
        }
    }
    
}
