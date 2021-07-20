package linksharing

class ResourceRating {
    int score

//    resource
//    user
    static belongsTo = [resource:Resource,user:User]

    static constraints = {
        score blank: false
    }
}
