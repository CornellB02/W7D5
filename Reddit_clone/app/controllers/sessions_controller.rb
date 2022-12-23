class SessionsController < ApplicationController
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

    def destroy
        if logged_in?
            log_out!
        end

        flash[:message] = ["SUccessfully logged out"]

        redirect_to new_session_url
    end
end
