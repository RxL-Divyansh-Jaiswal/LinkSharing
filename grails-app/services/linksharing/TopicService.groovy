package linksharing

import dto.TopicDetailDTO
import grails.gorm.transactions.Transactional
import linksharing.enums.Seriousness
import linksharing.enums.Visibility
import org.springframework.web.multipart.MultipartFile

@Transactional
class TopicService {

    def serviceMethod() {

    }

//  create service
    def create(User user, String name, String visibility) {
        Map response = [:]
        User creator = User.findById(user.id)
        if(Topic.findByNameAndCreatedBy(name,user)){
            response.msg = "You cannot create two topics with same name, Try again with other name"
        }else{
            Topic newTopic = new Topic(name: name, visibility: Visibility.valueOf(visibility))
            newTopic.createdBy = creator

            try {
                newTopic.save(flush: true, failOnError: true)

                Subscription newSubscription = new Subscription(subscriber: creator, topic: newTopic, seriousness: Seriousness.Very_Serious)
                newSubscription.save(flush:true)
                creator.subscriptions.add(newSubscription)

                response.msg = "Topic created Successfully"
                response.topic = newTopic
            } catch (Exception e) {
                response.msg =  "Error in creating topic"
            }
        }

        response
    }

//  link resource service
    def linkResource(User user, String topic, String description, String url){
        Map response = [:]
        User creator = User.findById(user.id)
        Topic relTopic = Topic.findByName(topic)

        LinkResource lRes = new LinkResource(createdBy: creator, topic: relTopic, description: description, url: url)

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

            response.msg =  "Link Resource Created Successfully"
            response.resource = lRes
        }catch(Exception e){
            println e
            response.msg =  "Error in creating link resource"
        }

        response
    }

//  doc resource service
    def docResource(User user, String topic, String description, MultipartFile file){
        Map response = [:]
        User creator = User.findById(user.id)
        Topic relTopic = Topic.findByName(topic)

        String docName = "${file.originalFilename.split("\\.")[0]}" + ".${file.originalFilename.split("\\.")[-1]}"

        String docPath

        if(file && !file.empty) {
            File document = new File("/home/rxlogix/IdeaProjects/LinkSharing/grails-app/assets/docFiles/${docName}")
            file.transferTo(document)
            docPath = document.path
        }

        DocumentResource dRes = new DocumentResource(createdBy: creator, topic: relTopic, description: description, name: file.originalFilename, filePath: docPath)

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

            response.msg =  "Document Resource Created Successfully"
            response.resource = dRes
        }catch(Exception e){
            response.msg = "Error in creating document resource"
        }
        response
    }

//  search service
    def search(String text){
        List<Topic> topics = Topic.findAllByNameIlikeAndVisibility("${text}%",Visibility.Public)
        return topics
    }

//  subscribe service
    def subscribe(User user,int id){
        Topic topic = Topic.findById(id)
        Subscription subscription = new Subscription(subscriber: user, topic: topic, seriousness: Seriousness.Very_Serious)

        subscription.save(flush: true, failOnError: true)
        topic.subscriptions.add(subscription)
        subscription
    }

//  unsubscribe service
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

//  trending topics service
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

        list.sort({ a, b -> a.postCount == b.postCount ? 0 : a.postCount < b.postCount ? 1 : -1 })
    }

//  visibility service
    def visibility(int id, String visibility){
        Topic topic = Topic.findById(id)
        topic.visibility = Visibility.valueOf(visibility)
        topic.save(flush: true)
        return "Visibility Changed"
    }

//  seriousness service
    def seriousness(int id, String seriousness){
        Subscription subscription = Subscription.findById(id)
        subscription.seriousness = Seriousness.valueOf(seriousness)
        subscription.save(flush:true)
        return "Seriousness Changed"
    }

//  invite service
    def invite(String email, String topicName){
        Map response = [:]
        User user = User.findByEmail(email)

        if(!user){
            response.msg = "Cannot find any user with this email"
        }else{
            Topic relTopic = Topic.findByName(topicName)
            Subscription subscription = Subscription.findByTopicAndSubscriber(relTopic,user)
            if(subscription){
                response.msg = "User is already subscribed to this topic"
            }else{
                Subscription newSubscription = new Subscription(subscriber: user,topic: relTopic, seriousness: Seriousness.Serious)

                try{
                    newSubscription.save(flush:true,failOnError:true)
                    relTopic.subscriptions.add(newSubscription)
                    user.subscriptions.add(newSubscription)
                    response.msg = "Invited Successfully"
                    response.subscription = newSubscription
                }catch(Exception e){
                    response.msg = "Error in inviting"
                }
            }
        }

        response
    }

//  update name service
    def update(int id, String new_name){
        Topic topic = Topic.findById(id)
        String prevName = topic.name

        topic.name = new_name

        try{
            topic.save(flush:true,failOnError: true)
            return "Name changed successfully"
        }catch(Exception e){
            topic.name = prevName
            topic.save(flush:true)
            return "Error in changing the name"
        }
    }

//  delete service
    def delete(int id) {
        Topic topic = Topic.findById(id)

        try {
            List<Subscription> subscriptions = Subscription.findAllByTopic(topic)
            List<Resource> resources = Resource.findAllByTopic(topic)
            Subscription.deleteAll(subscriptions)
            Resource.deleteAll(resources)
            topic.delete(flush: true,failOnError: true)
            return "Topic Deleted Successfully"
        } catch (Exception e) {
            return "Error in deleting topic"
        }
    }
}
