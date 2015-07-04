class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user_path(user), notice: "Login Successful"
    else
      flash[:alert] = "Login failed. Please check your email and password."
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    reset_session
    redirect_to root_url , notice: "You have been logged out."
  end

end
