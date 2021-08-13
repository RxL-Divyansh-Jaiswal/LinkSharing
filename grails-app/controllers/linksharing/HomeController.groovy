package linksharing

class HomeController {

    def index() {
        if(session.user){
            redirect(controller: "user", action: "dashboard")
        }else{
            render(view: 'index')
        }
    }

    def home(){
        if(session.user){
            redirect(controller: "user", action: "dashboard")
        }else{
            redirect url: "/"
        }
    }

    def dummy(){
        flash.info = "Please login or register to continue..."

        redirect url: "/"
    }
}
