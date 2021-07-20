package linksharing

class LinkResource {
    String url

    static belongsTo = [resource: Resource]

    static constraints = {
        url blank: false
    }
}
