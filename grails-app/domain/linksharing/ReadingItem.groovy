package linksharing

class ReadingItem {
    boolean isRead

//    resource
//    user
    static belongsTo = [resource:Resource,user:User]

    static constraints = {
        isRead blank: false
    }
}
