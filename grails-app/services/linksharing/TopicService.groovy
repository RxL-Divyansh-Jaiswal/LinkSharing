package linksharing

import dto.TopicDetailDTO
import grails.gorm.transactions.Transactional
import linksharing.enums.Seriousness
import linksharing.enums.Visibility

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
            creator.resources.add(lRes)

            User.list().each{
                if(it == creator){
                    ReadingItem readingItem = new ReadingItem(isRead: true, user: it, resource: lRes)
                    readingItem.save(flush:true)
                    it.readingItems.add(readingItem)
                }else{
                    if(Subscription.findByTopicAndSubscriber(relTopic,it)){
                        ReadingItem readingItem = new ReadingItem(isRead: false, user: it, resource: lRes)
                        readingItem.save(flush:true)
                        it.readingItems.add(readingItem)
                    }
                }
            }

            return "Link Resource created and added to list successfully"
        }catch(Exception e){
            println e
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
            creator.resources.add(dRes)

            User.list().each{
                if(it == creator){
                    ReadingItem readingItem = new ReadingItem(isRead: true, user: it, resource: dRes)
                    readingItem.save(flush:true)
                    it.readingItems.add(readingItem)
                }else{
                    if(Subscription.findByTopicAndSubscriber(relTopic,it)){
                        ReadingItem readingItem = new ReadingItem(isRead: false, user: it, resource: dRes)
                        readingItem.save(flush:true)
                        it.readingItems.add(readingItem)
                    }
                }
            }

            return  "Document Resource created and added to list successfully"
        }catch(Exception e){
            println e
            return "Error in creating document resource"
        }
    }

    def search(String text){
        List<Topic> topics = Topic.findAllByNameLikeAndVisibility(text,"Public")
        return topics
    }

    def subscribe(User user,int id){
        Topic topic = Topic.findById(id)
        Subscription subscription = new Subscription(subscriber: user,topic: topic, seriousness: Seriousness.Very_Serious)

        try{
            subscription.save(flush:true,failOnError:true)
            topic.subscriptions.add(subscription)
            return subscription
        }catch(Exception e){
            return null
        }
    }

    def unsubscribe(User user, int id){
        Topic topic = Topic.findById(id)

        if(topic.createdBy.id == user.id){
            return null
        }else{
            Subscription temp = Subscription.findByTopicAndSubscriber(topic,user)
            Subscription.findByTopicAndSubscriber(topic,user).delete()
            return temp
        }
    }

    def trending(User user){
        List<Topic> topics = Topic.findAllByVisibility("Public")
        List<TopicDetailDTO> list = []

        topics.each{
            if(Subscription.findByTopicAndSubscriber(it,user)){
                list << new TopicDetailDTO(topicId: it.id, topicName: it.name, subsCount: it.subscriptions.size(), postCount: it.resources.size(), creatorId: it.createdBy.id, creatorPhoto: it.createdBy.photo, creatorName: it.createdBy.name, creatorUserName: it.createdBy.userName, isSubscribed: true, subsId: Subscription.findByTopicAndSubscriber(it,user).id, seriousness: Subscription.findByTopicAndSubscriber(it,user).seriousness,visibility: Visibility.Public)
            }else{
                list << new TopicDetailDTO(topicId: it.id, topicName: it.name, subsCount: it.subscriptions.size(), postCount: it.resources.size(), creatorId: it.createdBy.id,creatorPhoto: it.createdBy.photo, creatorName: it.createdBy.name, creatorUserName: it.createdBy.userName, isSubscribed: false)
            }

        }

        return list.sort({ a, b -> a.postCount == b.postCount ? 0 : a.postCount < b.postCount ? 1 : -1 })
    }

    def delete(User user, int id) {
        Topic topic = Topic.findById(id)

        try {
            List<Subscription> subscriptions = Subscription.findAllByTopic(topic)
            List<Resource> resources = Resource.findAllByTopic(topic)
            Subscription.deleteAll(subscriptions)
            Resource.deleteAll(resources)
            topic.delete(flush: true,failOnError: true)
            return "Topic along with associated subscriptions and resources deleted successfully"
        } catch (Exception e) {
            return "Error in deleting topic"
        }
    }
}
