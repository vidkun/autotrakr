class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Login Successful"
      redirect_to user_path(user)
    else
      flash[:error] = "Login failed. Please check your email and password."
      render :new
    end
  end

  def destroy
  end

end
