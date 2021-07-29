package linksharing

class TopicController {

    def topicService

    def index() { }

    def createTopic(){
        User currUser = session.user

        String msg = topicService.create(currUser,params)

        render msg
    }

    def deleteTopic(int id){
        User currUser = session.user

        String msg = topicService.delete(currUser,id)

        render msg
    }
}
