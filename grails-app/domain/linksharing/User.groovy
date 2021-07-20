package linksharing

class User {
    String email
    String userName
    String password
    String firstName
    String lastName
    Byte photo
    boolean admin
    Date dateCreated
    Date lastUpdated

    static hasMany = [topics:Topic,subscriptions:Subscription,resources:Resource,readingItems:ReadingItem]
//    resourceRating check

    static constraints = {
        email(unique: true, email: true)
        userName(unique: true, blank: false)
        firstName blank: false
        password blank: false
    }
}