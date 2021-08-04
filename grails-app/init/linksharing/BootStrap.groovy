package linksharing

class BootStrap {

    def init = { servletContext ->
        createUser()
    }

    def createUser(){
        List<User> users = []
        users << new User(firstName: "Divyansh", lastName: "Jaiswal", userName: "divysJais", password: "123456", email: "divyansh.jaiswal@rxlogix.com", active: "true", photo: "/avatars/default_Profile.jpg")
        users << new User(firstName: "Sarthak", lastName: "Singh", userName: "sarthakRocks", password: "123456", email: "sarthak.singh@rxlogix.com", active: "true", photo: "/avatars/default_Profile.jpg")
        users << new User(firstName: "Bhupender", lastName: "Singh", userName: "bhuppii", password: "123456", email: "bhupender.singh@rxlogix.com", active: "true", photo: "/avatars/default_Profile.jpg")

        users.each { it.save(flush: true) }
    }

    def destroy = {
    }
}
