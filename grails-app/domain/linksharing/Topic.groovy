package linksharing

class Topic {
    String name
    Date dateCreated
    Date lastUpdated

//  createdBy user
//  resources
    static belongsTo = [createdBy:User]
    static hasMany = [resources:Resource]

//  enum visibility
    static constraints = {
        name blank: false
    }
}
