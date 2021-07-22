package linksharing

class Resource {
    String description
    User createdBy
    Date dateCreated
    Date lastUpdated

//    topic
    static belongsTo = [topic:Topic]

//   readingItems
//   ratings
    static hasMany = [readingItems:ReadingItem,resourceRatings:ResourceRating]

    static constraints = {
        description maxSize: 1000
    }

    static mapping = {
        table 'RES'
    }
}
