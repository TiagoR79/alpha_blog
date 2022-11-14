class UsersController < ApplicationController

    before_action :set_user
    
    def show
        @articles = User.find(params[:id]).articles
    end

    def index
        @users = User.all
    end
    
    def new
        @user = User.new
    end
    
    def edit 
    end

    def update
        if @user.update(user_params)
            flash[:notice] = "Account updated successfully"
            redirect_to @user
        else
            render 'edit'
        end
    end

    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            flash[:notice] = "Welcome to Alpha Blog #{ @user.username }"
            redirect_to articles_path
        else
            render 'new'
        end
    end

    private 
    def user_params
        params.require(:user).permit(:username, :email, :password)
    end

    def set_user
        @user = User.find(params[:id])
    end
end