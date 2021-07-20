package linksharing

class DocumentResource {
    String filePath

    static constraints = {
        filePath blank: false
    }

    static mapping = {
        table 'DocRes'
    }
}
