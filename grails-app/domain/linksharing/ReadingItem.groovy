package linksharing

class ReadingItem {
    boolean isRead
    User user

//    resource
    static belongsTo = [resource:Resource]

    static constraints = {
    }
}
