  class SessionsController < ApplicationController
    def new
    end

    #loginging in systems
    def create
    user = User.find_by_username(params[:username])
    if user && user.authenticate(params[:password])
      if params[:remember_me]
        cookies.permanent[:auth_token] = user.auth_token
      else
        cookies[:auth_token] = user.auth_token
      end
       session[:user_id] = user.id
      redirect_to home_path, notice: "You are logged into the chess camp system"
    else
      flash.now.alert = "Username or password is invalid"
      render "new"
    end
  end

  def destroy
    cookies.delete(:auth_token)
    session[:user_id] = nil
    redirect_to home_path, notice: "Logged out!"
  end
end