class ApplicationController < ActionController::Base
    
    helper_method :current_user, :logged_in?

    def current_user
        #To not query the DB ever time -> use current_user or query 
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
    
    def logged_in?
        #transform current_user in bool using '!!'
        !!current_user
    end

    def require_user
        if !logged_in?
            flash[:alert] = "You must be logged in to perform that action"
            redirect_to login_path
        end
    end

end
