class UsersController < ApplicationController
    def index
        @users = User.all 
        render :index
    end

    def show
        @user = User.find_by(id: params[:id])
        if @user
            render :show
        else
            redirect_to new_user_url
        end
    end

    def new
        @user = User.new
        render :new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            redirect_to user_url(@user)
        else
            redirect_to new_user_url
        end
    end

    def user_params
        params.require(:user).permit(:username, :password)
    end

end
