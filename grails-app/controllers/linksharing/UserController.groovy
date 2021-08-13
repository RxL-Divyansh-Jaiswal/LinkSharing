package linksharing

import dto.UserDetailsDTO
import grails.converters.JSON
import org.hibernate.validator.internal.metadata.facets.Validatable
import org.springframework.web.multipart.MultipartFile

class UserController {

    def userService // user service
    def topicService // topic service

    def index() { }

//  user dashboard
    def dashboard(){
        if(!session.user){
            redirect url: "/"
        }else{
            List<Subscription> subscriptions = userService.subscriptions(session.user) // user subscriptions
            List trendingTopics = topicService.trending(session.user) // trending topics
            List<Resource> resources = Resource.all // all resources for inbox to be displayed as per need
            render(view: 'dashboard', model: [subscriptions: subscriptions, resources: resources, trendingTopics: trendingTopics])
        }
    }

//  user private page
    def privateProfile(){
        if(!session.user){
            redirect url: "/"
        }else{
            List<Topic> topics = Topic.findAllByCreatedBy(session.user)  // all topics of user
            render(view: 'privateProfile', model: [topics:topics])
        }
    }

//  user public page
    def publicProfile(){
        if(!session.user){
            redirect url: "/"
        }else {
            User u = User.findById(params.int("id")) // user
            List<Topic> topics = Topic.findAllByCreatedBy(u) // all topics of user
            List<Subscription> subscriptions = Subscription.all
            // all subscriptions for subscription list to be displayed as needed
            List<Resource> resources = Resource.findAllByCreatedBy(u) // all resources of user
            render(view: "publicProfile", model: [user: u, topics: topics, subscriptions: subscriptions, resources: resources])
        }
    }

//  register a new user
    def registerUser(UserCommand cmd,def request){
        MultipartFile image = request.getFile('image')
        Map response = userService.register(cmd.firstName,cmd.lastName,cmd.email,cmd.userName,cmd.password,cmd.cnf_password,cmd.question,cmd.answer,image)

        if(response.user){
            flash.success = response.msg
        }else{
            flash.error = response.msg
        }

        redirect url: "/"
    }

//  login a registered user
    def loginUser(String email, String password) {
        Map response = userService.login(email, password) // calling login service
        if (response.user) {
            session.setAttribute("user", response.user)
            redirect(action: "dashboard")
        } else {
            flash.error = response.get('msg')
            redirect url: "/"
        }
    }

//  view a user's profile
    def getProfile(){
        if(!session.user){
            redirect url: "/"
        }else {
            User visiting = User.findById(params.int("id")) // user to be viewed
            Map map = ['currUser': session.user, 'visitingUser': visiting]
            String response = userService.profile(map) // calling profile service

//      redirecting based on response
            if (response == "Private Page") {
                redirect(action: "privateProfile")
            } else {
                redirect(action: "publicProfile", id: visiting.id)
            }
        }
    }

//  upadate profile of a logged in user
    def updateProfile(UserCommand cmd, def request){
        MultipartFile image = request.getFile("image")
        Map response = userService.profileUpdate(session.user,cmd.email,cmd.firstName,cmd.lastName,cmd.userName,image)

        if(response.msg == "Updated Successfully"){
            flash.success = response.msg
        }else{
            flash.error = response.msg
        }

        session.setAttribute("user",response.user) // setting user in session
        redirect(action: "privateProfile")
    }

//  update password of a logged in user
    def updatePassword(String password, String cnf_password){
        String response = userService.passwordUpdate(session.user,password,cnf_password) // calling password update service

//      redirecting based on response
        if(response == "Updated Successfully"){
            flash.success = response
        }else{
            flash.error = response
        }
        redirect(action: "privateProfile")
    }

//  logout a user
    def logout(){
        session.invalidate()
        flash.success = "Logged Out Successfully..."
        redirect url: "/"
    }

//  list of all user for admin's users page
    def allUsers(){
        List users = User.all
        render(view: "allUsers", model: [users: users])
    }

//  activate a user
    def activateUser(int id){
        String response =  userService.activate(id) // calling activate service

//      redirecting based on response
        if(response == "User Activated"){
            flash.success = response
        }
        redirect(uri: request.getHeader('referer'))
    }

//  deactivate a user
    def deactivateUser(int id){
        String response = userService.deactivate(id) //calling deactivate service

//      redirecting based on response
        if(response == "User Deactivated"){
            flash.success = response
        }
        redirect(uri: request.getHeader('referer'))
    }

//  forget password page
    def forgetPassword(){}

//  validating user email for resetting the password
    def checkUser(String email){
        Map response = userService.findUser(email) // calling find user service

//      redirecting based on response
        List<UserDetailsDTO> ans = []
        if(response.user){
            ans << new UserDetailsDTO(email: response.user.email, ques: response.user.question)
        }

        render(ans as JSON)
    }

//  reset password of a logged out user
    def resetPassword(UserCommand cmd){
        Map response = userService.reset(cmd.email,cmd.answer,cmd.password,cmd.cnf_password)

        if(response.user){
            flash.success = response.msg
            redirect url: "/"
        }else{
            flash.error = response.msg
            redirect(uri: request.getHeader('referer'))
        }
    }
}

// CO
class UserCommand{
    String firstName
    String lastName
    String email
    String userName
    String password
    String cnf_password
    String question
    String answer

    static constraints = {
        email(unique: true, email: true)
        userName(unique: true)
        password(size: 5..15, blank: false)
        cnf_password(size: 5..15, blank: false)
    }
}
