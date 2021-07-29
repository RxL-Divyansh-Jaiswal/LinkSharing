package linksharing

import grails.gorm.transactions.Transactional

@Transactional
class UserService {

    def serviceMethod() {}

    def register(def request, Map params){
        if(params.password != params.cnf_password){
//          redirect back with error msg
            return "Passwords don't match, Please try again..."
        }else{
            User newUser = new User(params)
            def file = request.getFile('image')

            if (file && !file.empty) {
                File photo = new File("/home/rxlogix/IdeaProjects/LinkSharing/grails-app/assets/images/avatars/${params.userName}.jpg")
                file.transferTo(photo)
                newUser.photo = "/avatars/${params.userName}.jpg"
            }

            newUser.active = true

            try {
//              redirect back with success msg
                newUser.save(flush:true,failOnError:true)
                return "Registered Successfully, Please Login to continue..."
            }catch(Exception e) {
//              redirect back with error msg
                return "Error in registering, Please try again..."
            }
        }
    }

    Map login(Map params){
        Map map = [:]
        String msg
        User user = User.findByEmail(params.email)

        if(user == null){
//          redirect back with error msg
            msg = "No account associated with this email"
        }else{
            if(params.password != user.password) {
//            redirect back with an error msg
                if(user.active == false){
                    msg = "Please contact admin"
                }
                msg = "Invalid email/password"
            }

            map.put('user',user)
            msg = "Login Successfully"
        }

        map.put('msg',msg)
        return map
    }

    def activate(int id){
        User user = User.findById(id)

        if(user.active == true){
            return "No changes made"
        }else{
            user.active = true
            user.save(flush: true)
            return "User Activated"
        }
    }

    def deactivate(int id){
        User user = User.findById(id)

        if(user.active == false || user.active == null){
            return "No changes made"
        }else{
            user.active = false
            user.save(flush: true)
            return "User deactivated"
        }
    }
}
