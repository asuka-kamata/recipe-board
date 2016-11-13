module SessionsHelper
    
    def current_user
        @current_user ||= User.find_by(id: session[:user_id])
    end
    
    def logged_in?
        !!current_user
    end
    
    #リクエストがGETの場合、session[:forwarding_url]に
    #リクエストのURLを代入
    def store_location
        session[:forwarding_url] = request.url if request.get?
    end
    
end
