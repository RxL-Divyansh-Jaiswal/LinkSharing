package linksharing

import grails.gorm.transactions.Transactional
import grails.web.servlet.mvc.GrailsParameterMap
import org.springframework.web.multipart.MultipartFile

@Transactional
class UserService {

    def serviceMethod() {}

//  register service
    Map register(String firstName, String lastName, String email, String userName, String password, String cnf_password, String question, String answer, MultipartFile image) {
        Map response = [:]
        if (password != cnf_password) {
            response.msg = "Passwords don't match, Please try again..."
        } else {
            User newUser = new User(firstName: firstName, lastName: lastName, email: email, userName: userName, password: password, question: question, answer: answer)
            try {
                newUser.save(flush: true, failOnError: true)
                String extension = "${image.originalFilename.split("\\.")[-1]}"

                if (image && !image.empty) {
                    File photo = new File("/home/rxlogix/IdeaProjects/LinkSharing/grails-app/assets/images/avatars/${userName}.${extension}")
                    image.transferTo(photo)
                    newUser.photo = "/avatars/${userName}.${extension}"
                } else {
                    newUser.photo = "/avatars/default_Profile.jpg"
                }

                newUser.active = true
                response.msg = "Registered Successfully, Please Login to continue..."
                response.user = newUser
            } catch (Exception e) {
                println e
                response.msg =  "Error in registering, Please try again..."
            }
        }
        response
    }

//  login service
    Map login(String email, String password){
        Map response = [:]
        User user = User.findByEmail(email)
        if (user) {
            if (password != user.password) {
                response.msg = "Invalid email/password"
            } else {
                if (!user.active) {
                    response.msg = "Please contact admin"
                } else {
                    response.put('user', user)
                }
            }
        } else {
            response.msg = "No account associated with this email"
        }

        response
    }

//  getting list of user subscriptions
    List subscriptions(User user){
        return Subscription.findAllBySubscriber(user)
    }

//  profile service
    def profile(Map map){
        if(map.get('currUser').id == map.get('visitingUser').id){
            return "Private Page"
        }else{
            return "Public Page"
        }
    }

//  update profile service
    Map profileUpdate(User user, String email, String firstName, String lastName, String userName, MultipartFile image){
        Map response = [:]
        File prevPhoto = new File("/home/rxlogix/IdeaProjects/LinkSharing/grails-app/assets/images/${user.photo}") // prev photo of user if available
        String extension = "${image.originalFilename.split("\\.")[-1]}" // extension of new photo
        String newPhoto

        if(image && !image.empty) {
            if(user.photo == "/avatars/default_Profile.jpg"){
                File photo = new File("/home/rxlogix/IdeaProjects/LinkSharing/grails-app/assets/images/avatars/${user.userName}.${extension}")
                image.transferTo(photo)
                newPhoto = "/avatars/${user.userName}.${extension}"
            }else{
                prevPhoto.delete()
                File photo = new File("/home/rxlogix/IdeaProjects/LinkSharing/grails-app/assets/images/avatars/${user.userName}.${extension}")
                image.transferTo(photo)
                newPhoto = "/avatars/${user.userName}.${extension}"
            }
        }else{
            newPhoto = user.photo
        }

//      map with updated fields
        Map map = ['email':email,'firstName':firstName,'lastName':lastName,'userName':userName, 'photo':newPhoto,'id':user.id]

        try{
            User.executeUpdate('update User set email=:email, firstName=:firstName, lastName=:lastName, userName=:userName, photo=:photo where id=:id',map)
            User modifiedUser = User.findById(user.id)

            response.user = modifiedUser
            response.msg ="Updated Successfully"
        }catch(Exception e){
            response.user = user
            response.msg = "Error in updating..."
        }

        response
    }

//  update password service
    def passwordUpdate(User user,String password, String cnf_password){
        String response
        if(password != cnf_password){
//          redirect back with error msg
            response = "Passwords don't match, Please try again..."
        }else{
//          update user password
            User u = User.findById(user.id)
            u.password = password

            try{
                u.save(flush:true,failOnError:true)
                response = "Updated Successfully"
            }catch(Exception e){
                response = "Error in updating..."
            }

            response
        }
    }

//  activate service
    def activate(int id){
        User user = User.findById(id)

        if(user.active){
            return "No changes made"
        }else{
            user.active = true
            user.save(flush: true)
            return "User Activated"
        }
    }

//  deactivate service
    def deactivate(int id){
        User user = User.findById(id)

        if(!user.active || !user.active){
            return "No changes made"
        }else{
            user.active = false
            user.save(flush: true)
            return "User Deactivated"
        }
    }

//  finding user
    Map findUser(String email){
        Map response = [:]
        User u = User.findByEmail(email)
        String msg = u != null ? "Found the user" : "No account with this email"

        response.user = u
        response.msg = msg

        response
    }

//  password reset service
    Map reset(String email, String answer, String new_password, String cnf_password){
        User u = User.findByEmail(email) // finding user by email
        Map response = [:]

        if(u.answer != answer){
            response.msg = "Answer don't match, try again..."
        }else{
            if(new_password != cnf_password){
                response.msg = "Passwords don't match, Please try again..."
            }else{
                u.password = new_password

                try{
                    u.save(flush:true,failOnError:true)
                    response.user = u
                    response.msg = "Password Reset Successful..."
                }catch(Exception e){
                    response.msg = "Error in resetting the password..."
                }
            }
        }

        response
    }
}
