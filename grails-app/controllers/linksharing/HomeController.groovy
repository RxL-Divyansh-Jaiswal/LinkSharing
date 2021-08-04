package linksharing

class HomeController {

    def index() {
        render(view: 'index')
    }

    def home(){
        if(session.user != null){
            redirect(controller: "user", action: "dashboard")
        }else{
            redirect url: "/"
        }
    }
}
