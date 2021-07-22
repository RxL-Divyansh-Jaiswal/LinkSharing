package linksharing

import linksharing.enums.Seriousness

class Subscription {
    User subscriber
    Seriousness seriousness
    Date dateCreated

//  topic
    static belongsTo = [topic:Topic]

//  enum seriousness
    static constraints = {
    }
}
