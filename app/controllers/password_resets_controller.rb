class PasswordResetsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user
      user.generate_password_reset_token!
      Notifier.password_reset(user).deliver
      redirect_to login_path
    else
      render :new
    end
    flash[:notice] = "An email has been sent with further instructions"
  end
end
