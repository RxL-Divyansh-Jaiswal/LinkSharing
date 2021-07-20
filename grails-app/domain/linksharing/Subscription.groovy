package linksharing

class Subscription {
    Date dateCreated

//  topic
//  user
    static belongsTo = [topic:Topic,user:User]

//  enum seriousness
    static constraints = {
    }
}
