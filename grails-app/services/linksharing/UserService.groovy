package linksharing

import grails.gorm.transactions.Transactional
import grails.web.servlet.mvc.GrailsParameterMap

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
            String extension = "${file.originalFilename.split("\\.")[-1]}"

            if(file && !file.empty) {
                File photo = new File("/home/rxlogix/IdeaProjects/LinkSharing/grails-app/assets/images/avatars/${params.userName}.${extension}")
                file.transferTo(photo)
                newUser.photo = "/avatars/${params.userName}.${extension}"
            }else{
                newUser.photo = "/avatars/default_Profile.jpg"
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
                msg = "Invalid email/password"
            }else{
                if(user.active == false){
                    msg = "Please contact admin"
                }else{
                    map.put('user',user)
                    msg = "Login Successfully"
                }
            }
        }

        map.put('msg',msg)
        return map
    }

    List subscriptions(User user){
        return Subscription.findAllBySubscriber(user)
    }

    def profile(Map map){
        if(map.get('currUser').id == map.get('visitingUser').id){
            return "Private Page"
        }else{
            return "Public Page"
        }
    }

    Map profileUpdate(def request,User user,Map params){
        Map res = [:]

        File prevPhoto = new File("/home/rxlogix/IdeaProjects/LinkSharing/grails-app/assets/images/${user.photo}")
        def file = request.getFile('image')
        String extension = "${file.originalFilename.split("\\.")[-1]}"

        String newPhoto

        if(file && !file.empty) {
            if(user.photo == "/avatars/default_Profile.jpg"){
                File photo = new File("/home/rxlogix/IdeaProjects/LinkSharing/grails-app/assets/images/avatars/${user.userName}.${extension}")
                file.transferTo(photo)
                newPhoto = "/avatars/${user.userName}.${extension}"
            }else{
                prevPhoto.delete()
                File photo = new File("/home/rxlogix/IdeaProjects/LinkSharing/grails-app/assets/images/avatars/${user.userName}.${extension}")
                file.transferTo(photo)
                newPhoto = "/avatars/${user.userName}.${extension}"
            }
        }else{
            newPhoto = user.photo
        }

        Map map = ['email':params.email,'firstName':params.firstName,'lastName':params.lastName,'userName':params.userName, 'photo':newPhoto,'id':user.id]

        User.executeUpdate('update User set email=:email, firstName=:firstName, lastName=:lastName, userName=:userName, photo=:photo where id=:id',map)
        User modifiedUser = User.findById(user.id)

        res.put('user',modifiedUser)
        res.put('msg', "Updated Successfully")
        return res
    }

    def passwordUpdate(User user,Map params){
        if(params.password != params.cnf_password){
            return "Passwords don't match, Please try again..."
        }else{
            User.executeUpdate('update User set password=:password where id=:id',['password':params.password,'id':user.id])
            return "Updated Successfully"
        }
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
            return "User Deactivated"
        }
    }

    def reset(Map params){
        User u = User.findByEmail(params.email)

        if(u.answer != params.answer){
            return "Answer don't match, try again..."
        }else{
            if(params.new_password != params.cnf_password){
                return "Passwords don't match, Please try again..."
            }else{
                User.executeUpdate('update User set password=:password where id=:id',['password':params.new_password,'id':u.id])
                return "Password Reset Successful..."
            }
        }
    }
}
