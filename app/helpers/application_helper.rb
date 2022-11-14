module ApplicationHelper

    def current_user
        #To not query the DB ever time -> use current_user or query 
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def logged_in?
        #transform current_user in bool using '!!'
        !!current_user
    end
end
