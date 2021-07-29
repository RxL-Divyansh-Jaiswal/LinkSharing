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
            Subscription newSubscription = new Subscription(subscriber: creator, topic: newTopic, seriousness: Seriousness.VERY_SERIOUS)

            try {
                newSubscription.save(flush: true, failOnError: true)
                creator.subscriptions.add(newSubscription)
                creator.save(flush: true, failOnError: true)
            } catch (Exception e) {
                return "Topic created, but error in creating subscription"
            }

            return "Topic Created and Subscribed Successfully"
        } catch (Exception e) {
            return "Error in creating topic"
        }
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
