package linksharing

class UserController {

    def userService

    def index() { }

    def dashboard(){
        List<Subscription> subscriptions = userService.subscriptions(session.user)
        render(view: 'dashboard', model: [subscriptions: subscriptions])
    }

    def privateProfile(){
        render(view: 'privateProfile')
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
        User visiting = User.findById(params.id)
        Map map = ['currUser':session.user,'visitingUser':visiting]
        String msg = userService.profile(map)

        redirect(action: "privateProfile")
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

    def activateUser(int id){
        return userService.activate(id)
    }

    def deactivateUser(int id){
        return userService.deactivate(id)
    }
}
