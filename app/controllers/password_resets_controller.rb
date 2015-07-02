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

  def edit
    @user = User.find_by(password_reset_token: params[:id])
    render file: 'public/404.html', status: :not_found unless @user
  end

  def update
    @user = User.find_by(password_reset_token: params[:id])
    if @user && @user.update_attributes(user_params)
      @user.update_attributes(password_reset_token: nil)
      session[:user_id] = @user.id
      flash[:notice] = "Password successfully updated."
      redirect_to user_path(@user)
    else
      flash[:notice] = "Password reset token not found."
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:password,
                                 :password_confirmation)
  end
end
