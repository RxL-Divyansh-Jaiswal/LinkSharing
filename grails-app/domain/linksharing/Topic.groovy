package linksharing

import linksharing.enums.Visibility

class Topic {
    String name
    Visibility visibility
    Date dateCreated
    Date lastUpdated

//  createdBy user
//  resources
    static belongsTo = [createdBy:User]
    static hasMany = [subscriptions:Subscription,resources:Resource]

//  enum visibility
    static constraints = {
    }
}
