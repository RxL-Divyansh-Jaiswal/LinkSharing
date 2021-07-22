package linksharing

class UserController {

    def index() { }

    def registerUser(){
        User newUser = new User(params)
        newUser.save(flush:true)

//       render user dashboard
    }
}
