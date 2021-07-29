package linksharing

class UserController {

    def userService

    def index() { }

    def dashboard(){
        render(view: 'dashboard')
    }

    def registerUser(){
        String msg = userService.register(request,params)

        if(msg.split(" ")[0] == "Registered"){
            flash.success = msg
        }else{
            flash.resError = msg
        }

        redirect(controller: "home", action: "index")
    }

    def loginUser(){
        Map map = userService.login(params)

        if(map.get('msg').split(" ")[0] == "Login"){
            session.setAttribute("user",map.get('user'))
//           render "Login Successfully ${session.user.userName}"
            redirect(action: "dashboard")
        }else{
            flash.logError = map.get('msg')
            redirect(controller: "home", action: "index")
        }
    }

    def logout(){
        session.invalidate()
        redirect(controller: "home", action: "index")
    }

    def activateUser(int id){
        return userService.activate(id)
    }

    def deactivateUser(int id){
        return userService.deactivate(id)
    }
}
