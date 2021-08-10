package linksharing

class BootStrap {

    def init = { servletContext ->
        createUser()
    }

    def createUser(){
        List<User> users = []
        users << new User(firstName: "Tony", lastName: "Stark", userName: "jarvis", password: "admin", email: "admin@linksharing.com", active: true, admin: true, photo: "/avatars/jarvis.png", question: "What was your school/college name ?", answer: "mit")
        users << new User(firstName: "Divyansh", lastName: "Jaiswal", userName: "divysJais", password: "123456", email: "divyansh.jaiswal@rxlogix.com", active: "true", photo: "/avatars/default_Profile.jpg", question: "What is your nickname ?", answer: "golu")
        users << new User(firstName: "Sarthak", lastName: "Singh", userName: "sarthakRocks", password: "123456", email: "sarthak.singh@rxlogix.com", active: true, photo: "/avatars/sarthakRocks.png", question: "What was your school/college name ?", answer: "dtu")
        users << new User(firstName: "Bhupender", lastName: "Singh", userName: "bhuppii", password: "123456", email: "bhupender.singh@rxlogix.com", active: true, photo: "/avatars/default_Profile.jpg", question: "What is your nickname ?", answer: "bhuppi")
        users << new User(firstName: "Manish", lastName: "Khichi", userName: "manishX", password: "123456", email: "manish.khichi@rxlogix.com", active: true, photo: "/avatars/default_Profile.jpg", question: "What is your nickname ?", answer: "mannu")
        users << new User(firstName: "Rahul", lastName: "Khichar", userName: "kRahul", password: "123456", email: "rahul.khichar@rxlogix.com", active: true, photo: "/avatars/default_Profile.jpg", question: "What was your school/college name ?", answer: "iitr")
        users << new User(firstName: "Uddesh", lastName: "Teke", userName: "TekeUdd", password: "123456", email: "uddesh.teke@rxlogix.com", active: true, photo: "/avatars/default_Profile.jpg", question: "What was your school/college name ?", answer: "iitd")
        users << new User(firstName: "Hardik", lastName: "Gupta", userName: "gHardik", password: "123456", email: "hardik.gupta@rxlogix.com", active: true, photo: "/avatars/default_Profile.jpg", question: "What was your school/college name ?", answer: "dtu")

        users.each { it.save(flush: true) }
    }

    def destroy = {
    }
}
