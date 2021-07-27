package linksharing

class UserController {

    def index() { }

    def registerUser(){
            if(params.password != params.cnf_password){
                flash.passErr = "Passwords don't match, Please try again..."
            }else{
                User newUser = new User(params)

                try {
                    newUser.save(flush:true,failOnError:true)
                    flash.success = "Registered Successfully, Please Login to continue..."
                }catch(Exception e){
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
}
