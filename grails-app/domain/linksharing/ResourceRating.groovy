package linksharing

class ResourceRating {
    int score

//    resource
//    user
    static belongsTo = [resources:Resource,users:User]

    static constraints = {
        score blank: false
    }
}
