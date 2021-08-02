package linksharing

class LinkResource extends Resource{
    String url

    static constraints = {
        url(url: true)
    }
}
