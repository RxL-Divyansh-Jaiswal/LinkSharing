package linksharing

class User {
    String email
    String userName
    String password
    String firstName
    String lastName
    byte photo
    boolean admin
    boolean active
    Date dateCreated
    Date lastUpdated

    static transients = ['name']

    String getName(){
        return "${firstName} ${lastName}"
    }

    static hasMany = [
            topics:Topic,
            subscriptions:Subscription,
            resources:Resource,
            readingItems:ReadingItem,
            resourceRatings: ResourceRating]

    static constraints = {
        email(unique: true, email: true)
        photo nullable: true, blank: false
        password(size: 5..15, blank: false)
    }

    static mapping = {
        table 'USR'
    }
}