package linksharing

import grails.gorm.transactions.Transactional
import linksharing.enums.Seriousness

@Transactional
class TopicService {

    def serviceMethod() {

    }

    def create(User user, Map params) {
        User creator = User.findById(user.id)
        Topic newTopic = new Topic(params)
        newTopic.createdBy = creator

        try {
            newTopic.save(flush: true, failOnError: true)
            Subscription newSubscription = new Subscription(subscriber: creator, topic: newTopic, seriousness: Seriousness.Very_Serious)

            try {
                newSubscription.save(flush: true, failOnError: true)
                creator.subscriptions.add(newSubscription)
                creator.save(flush: true, failOnError: true)
            } catch (Exception e) {
                return "Topic created, but error in creating subscription"
            }

            return "Topic Created and Subscribed Successfully"
        } catch (Exception e) {
            println e
            return "Error in creating topic"
        }
    }

    def linkResource(User user, Map params){
        User creator = User.findById(user.id)
        Topic relTopic = Topic.findByName(params.topic)

        LinkResource lRes = new LinkResource(createdBy: creator, topic: relTopic, description: params.description, url: params.url)

        try{
            lRes.save(flush:true,failOnError:true)
            relTopic.resources.add(lRes)

            return "Link Resource created and added to list successfully"
        }catch(Exception e){
            return "Error in creating link resource"
        }
    }

    def docResource(User user, Map params, def request){
        User creator = User.findById(user.id)
        Topic relTopic = Topic.findByName(params.topic)

        def file = request.getFile('doc')
        String docName = "${file.originalFilename.split("\\.")[0]}" + ".${file.originalFilename.split("\\.")[-1]}"

        String docPath
        if(file && !file.empty) {
            File document = new File("/home/rxlogix/IdeaProjects/LinkSharing/grails-app/assets/docFiles/${docName}")
            file.transferTo(document)
            docPath = document.path
        }

        DocumentResource dRes = new DocumentResource(createdBy: creator, topic: relTopic, description: params.description, name: file.originalFilename, filePath: docPath)

        try{
            dRes.save(flush:true, failOnError: true)
            relTopic.resources.add(dRes)

            return  "Document Resource created and added to list successfully"
        }catch(Exception e){
            return "Error in creating document resource"
        }
    }

    def search(String text){
        List<Topic> topics = Topic.findAllByNameLikeAndVisibility(text,"Public")
        return topics
    }

    def delete(User user, int id) {
        Topic topic = Topic.findById(id)

        try {
            if(topic.createdBy == user || user.admin){
                List<Subscription> subscriptions = topic.subscriptions
                List<Resource> resources = topic.resources
                Subscription.deleteAll(subscriptions)
                Resource.deleteAll(resources)
                topic.delete()
            }
            return "Topic along with associated subscriptions and resources deleted successfully"
        } catch (Exception e) {
            return "Error in deleting topic"
        }
    }
}
