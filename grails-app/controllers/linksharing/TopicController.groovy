package linksharing

class TopicController {

    def topicService

    def index() { }

    def createTopic(){
        String msg = topicService.create(session.user,params)

        render msg
    }

    def deleteTopic(int id){
        String msg = topicService.delete(session.user,id)

        render msg
    }
}
