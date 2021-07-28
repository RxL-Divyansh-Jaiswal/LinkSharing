package linksharing

class UserController {

    def index() { }

    def registerUser(){
            if(params.password != params.cnf_password){
//              redirect back with error msg
                flash.passErr = "Passwords don't match, Please try again..."
            }else{
                User newUser = new User(params)

                try {
//                  redirect back with success msg
                    newUser.save(flush:true,failOnError:true)
                    flash.success = "Registered Successfully, Please Login to continue..."
                }catch(Exception e){
//                  redirect back with error msg
                    flash.resErr = "Error in registering, Please try again..."
                }

            }

            redirect(controller: "home", action: "index")
    }

    def loginUser(){
        User user = User.findByEmail(params.email)

        if(user == null){
//            redirect back with error msg
            flash.error = "No account associated with this email"
            redirect(controller: "home", action: "index")
        }else{
            if(params.password != user.password){
//                redirect back with an error msg
                flash.error = "Invalid email/password"
                redirect(controller: "home", action: "index")
            }

//            render user home page
            render "Login Successfully"
        }
    }

    def activateUser(int id){
        User user = User.findById(id)

        if(user.active == true){
            return
        }else{
            user.active = true
            user.save(flush: true)
        }
    }

    def deactivateUser(int id){
        User user = User.findById(id)

        if(user.active == false || user.active == null){
            return
        }else{
            user.active = false
            user.save(flush: true)
        }
    }
}
