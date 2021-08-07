package linksharing

class BootStrap {

    def init = { servletContext ->
        createUser()
    }

    def createUser(){
        List<User> users = []
        users << new User(firstName: "Tony", lastName: "Stark", userName: "jarvis", password: "admin", email: "admin@linksharing.com", active: true, admin: true, photo: "/avatars/default_Profile.jpg")
        users << new User(firstName: "Divyansh", lastName: "Jaiswal", userName: "divysJais", password: "123456", email: "divyansh.jaiswal@rxlogix.com", active: "true", photo: "/avatars/default_Profile.jpg")
        users << new User(firstName: "Sarthak", lastName: "Singh", userName: "sarthakRocks", password: "123456", email: "sarthak.singh@rxlogix.com", active: true, photo: "/avatars/default_Profile.jpg")
        users << new User(firstName: "Bhupender", lastName: "Singh", userName: "bhuppii", password: "123456", email: "bhupender.singh@rxlogix.com", active: true, photo: "/avatars/default_Profile.jpg")
        users << new User(firstName: "Manish", lastName: "Khichi", userName: "manishX", password: "123456", email: "manish.khichi@rxlogix.com", active: true, photo: "/avatars/default_Profile.jpg")
        users << new User(firstName: "Rahul", lastName: "Khichar", userName: "kRahul", password: "123456", email: "rahul.khichar@rxlogix.com", active: true, photo: "/avatars/default_Profile.jpg")
        users << new User(firstName: "Uddesh", lastName: "Teke", userName: "TekeUdd", password: "123456", email: "uddesh.teke@rxlogix.com", active: true, photo: "/avatars/default_Profile.jpg")
        users << new User(firstName: "Hardik", lastName: "Gupta", userName: "gHardik", password: "123456", email: "hardik.gupta@rxlogix.com", active: true, photo: "/avatars/default_Profile.jpg")

        users.each { it.save(flush: true) }
    }

    def destroy = {
    }
}
