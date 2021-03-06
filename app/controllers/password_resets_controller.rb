class PasswordResetsController < ApplicationController
  def new
  end

  def create
    user = User.where(email: params[:email]).first
    if user
      user.generate_password_reset_token!
      Notifier.password_reset(user).deliver_now
      redirect_to login_path
    else
      render :new
    end
    flash[:notice] = "An email has been sent with further instructions"
  end

  def edit
    @user = User.where(password_reset_token: params[:id]).first
    render file: "public/404.html", status: :not_found unless @user
  end

  def update
    @user = User.where(password_reset_token: params[:id]).first
    if @user && @user.update(user_params)
      @user.update({password_reset_token: nil})
      session[:user_id] = @user.id
      redirect_to user_path(@user),
                  notice: "Password successfully updated."
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
