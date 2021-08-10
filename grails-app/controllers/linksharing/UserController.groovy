package linksharing

import dto.UserDetailsDTO
import grails.converters.JSON

class UserController {

    def userService
    def topicService

    def index() { }

    def dashboard(){
        List<Subscription> subscriptions = userService.subscriptions(session.user)
        List trendingTopics = topicService.trending(session.user)
        List<Resource> resources = Resource.all
        render(view: 'dashboard', model: [subscriptions: subscriptions, resources: resources, trendingTopics: trendingTopics])
    }

    def privateProfile(){
        List<Topic> topics = Topic.findAllByCreatedBy(session.user)
        render(view: 'privateProfile', model: [topics:topics])
    }

    def publicProfile(){
        User u = User.findById(params.int("id"))
        List<Topic> topics = Topic.findAllByCreatedBy(u)
        List<Subscription> subscriptions = Subscription.findAllBySubscriber(u)
        List<Resource> resources = Resource.findAllByCreatedBy(u)

        render(view: "publicProfile", model: [user: u,topics:topics, subscriptions: subscriptions, resources: resources])
    }

    def registerUser(){
        String msg = userService.register(request,params)

        if(msg.split(" ")[0] == "Registered"){
            flash.success = msg
        }else{
            flash.resError = msg
        }

        redirect url: "/"
    }

    def loginUser(){
        Map map = userService.login(params)

        if(map.get('msg').split(" ")[0] == "Login"){
            session.setAttribute("user",map.get('user'))
            flash.logSuccess = "Logged In Successfully..."
            redirect(action: "dashboard")
        }else{
            flash.logError = map.get('msg')
            redirect url: "/"
        }
    }

    def getProfile(){
        User visiting = User.findById(params.int("id"))
        Map map = ['currUser':session.user,'visitingUser':visiting]
        String msg = userService.profile(map)

        if(msg == "Private Page"){
            redirect(action: "privateProfile")
        }else{
            redirect(action: "publicProfile", id: visiting.id)
        }
    }

    def updateProfile(){
        Map map = userService.profileUpdate(request,session.user,params)
        flash.profileSucc = map.get('msg')
        session.setAttribute("user",map.get('user'))

        redirect(action: "privateProfile")
    }

    def updatePassword(){
        String msg = userService.passwordUpdate(session.user,params)
        if(msg.split(" ")[0] == "Updated"){
            flash.passSuccess = msg
        }else{
            flash.passError = msg
        }

        redirect(action: "privateProfile")
    }

    def logout(){
        session.invalidate()
        flash.logSuccess = "Logged Out Successfully..."
        redirect url: "/"
    }


    def allUsers(){
        List users = User.all
        render(view: "allUsers", model: [users: users])
    }

    def activateUser(int id){
        String msg =  userService.activate(id)

        if(msg.split(" ")[0] == "User"){
            flash.statusMsg = msg
        }

        redirect(uri: request.getHeader('referer'))
    }

    def deactivateUser(int id){
        String msg = userService.deactivate(id)

        if(msg.split(" ")[0] == "User"){
            flash.statusMsg = msg
        }

        redirect(uri: request.getHeader('referer'))
    }

    def forgetPassword(){}

    def checkUser(){
        User u = User.findByEmail(params.email)
        String msg = u != null ? "Found the user" : "No account with this email"

        List list = []
        list << msg
        if(msg.split(" ")[0] == "Found"){
            list << new UserDetailsDTO(email: u.email, ques: u.question)
        }

        render(list as JSON)
    }

    def resetPassword(){
        String msg = userService.reset(params)

        if(msg.split(" ")[0] == "Password"){
            flash.resetSucc = msg
            redirect url: "/"
        }else{
            flash.msg = msg
            redirect(uri: request.getHeader('referer'))
        }
    }
}
