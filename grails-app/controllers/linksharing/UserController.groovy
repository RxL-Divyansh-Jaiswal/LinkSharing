package linksharing

import dto.UserDetailsDTO
import grails.converters.JSON

class UserController {

    def userService // user service
    def topicService // topic service

    def index() { }

//  user dashboard
    def dashboard(){
        List<Subscription> subscriptions = userService.subscriptions(session.user) // user subscriptions
        List trendingTopics = topicService.trending(session.user) // trending topics
        List<Resource> resources = Resource.all // all resources for inbox to be displayed as per need
        render(view: 'dashboard', model: [subscriptions: subscriptions, resources: resources, trendingTopics: trendingTopics])
    }

//  user private page
    def privateProfile(){
        List<Topic> topics = Topic.findAllByCreatedBy(session.user)  // all topics of user
        render(view: 'privateProfile', model: [topics:topics])
    }

//  user public page
    def publicProfile(){
        User u = User.findById(params.int("id")) // user
        List<Topic> topics = Topic.findAllByCreatedBy(u) // all topics of user
        List<Subscription> subscriptions = Subscription.all // all subscriptions for subscription list to be displayed as needed
        List<Resource> resources = Resource.findAllByCreatedBy(u) // all resources of user
        render(view: "publicProfile", model: [user: u,topics:topics, subscriptions: subscriptions, resources: resources])
    }

//  register a new user
    def registerUser(){
        String msg = userService.register(request,params) // calling register service

//      redirecting based on response
        if(msg.split(" ")[0] == "Registered"){
            flash.success = msg
        }else{
            flash.resError = msg
        }

        redirect url: "/"
    }

//  login a registered user
    def loginUser(){
        Map map = userService.login(params) // calling login service

//      redirecting based on response
        if(map.get('msg').split(" ")[0] == "Login"){
            session.setAttribute("user",map.get('user'))
            flash.logSuccess = "Logged In Successfully..."
            redirect(action: "dashboard")
        }else{
            flash.logError = map.get('msg')
            redirect url: "/"
        }
    }

//  view a user's profile
    def getProfile(){
        User visiting = User.findById(params.int("id")) // user to be viewed
        Map map = ['currUser':session.user,'visitingUser':visiting]
        String msg = userService.profile(map) // calling profile service

//      redirecting based on response
        if(msg == "Private Page"){
            redirect(action: "privateProfile")
        }else{
            redirect(action: "publicProfile", id: visiting.id)
        }
    }

//  upadate profile of a logged in user
    def updateProfile(){
        Map map = userService.profileUpdate(request,session.user,params) // calling update service
        String msg = map.get('msg')// response msg

//      redirecting based on response
        if(msg.split(" ")[0] == "Updated"){
            flash.profileSucc = msg
        }else{
            flash.profileErr = msg
        }
        session.setAttribute("user",map.get('user')) // setting user in session
        redirect(action: "privateProfile")
    }

//  update password of a logged in user
    def updatePassword(){
        String msg = userService.passwordUpdate(session.user,params) // calling password update service

//      redirecting based on response
        if(msg.split(" ")[0] == "Updated"){
            flash.passSuccess = msg
        }else{
            flash.passError = msg
        }
        redirect(action: "privateProfile")
    }

//  logout a user
    def logout(){
        session.invalidate()
        flash.logSuccess = "Logged Out Successfully..."
        redirect url: "/"
    }

//  list of all user for admin's users page
    def allUsers(){
        List users = User.all
        render(view: "allUsers", model: [users: users])
    }

//  activate a user
    def activateUser(int id){
        String msg =  userService.activate(id) // calling activate service

//      redirecting based on response
        if(msg.split(" ")[0] == "User"){
            flash.statusMsg = msg
        }
        redirect(uri: request.getHeader('referer'))
    }

//  deactivate a user
    def deactivateUser(int id){
        String msg = userService.deactivate(id) //calling deactivate service

//      redirecting based on response
        if(msg.split(" ")[0] == "User"){
            flash.statusMsg = msg
        }
        redirect(uri: request.getHeader('referer'))
    }

//  forget password page
    def forgetPassword(){}

//  validating user email for resetting the password
    def checkUser(){
        List list = userService.findUser(params.email) // calling find user service
        String msg = list[1]

//      redirecting based on response
        List<UserDetailsDTO> ans = []
        if(msg.split(" ")[0] == "Found"){
            ans << new UserDetailsDTO(email: list[0].email, ques: list[0].question)
        }
        render(ans as JSON)
    }

    def resetPassword(){
        String msg = userService.reset(params)

//      redirecting based on response
        if(msg.split(" ")[0] == "Password"){
            flash.resetSucc = msg
            redirect url: "/"
        }else{
            flash.msg = msg
            redirect(uri: request.getHeader('referer'))
        }
    }
}
