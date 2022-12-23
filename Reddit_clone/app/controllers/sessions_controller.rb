class SessionsController < ApplicationController
    def new
        @user = User.new
        render :new
    end

    def create
        debugger
        @user = User.find_by_creds(params[:user][:username], params[:user][:password])
        if @user
            log_in(@user)
            redirect_to user_url(@user)
        else
            @user = User.new(
                username: params[:user][:username],
                password: params[:user][:password]
            )
            render :new
        end
    end

    def destroy
        if logged_in?
            log_out!
        end
        flash[:message] = ["Successfully logged out"]
        redirect_to new_session_url
    end
end

        