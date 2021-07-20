package linksharing

class LinkResource {
    String url

    static constraints = {
        url blank: false
    }

    static mapping = {
        table 'LinkRes'
    }
}
