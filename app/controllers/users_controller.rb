class UsersController < ApplicationController
  # before_action :authenticate_user!, except: [:new, :create]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to user_url(@user),
                  notice: "Registration successful!"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_url(@user),
                  notice: "Update successful!"
    else
      render :edit
    end
  end

  def show
  end

  def destroy
    # Not sure I'm gonna keep this action. Do users need to be deleted?
    begin
      @user.destroy
      flash[:notice] = "User #{user.email} deleted!"
    rescue StandardError => e
      flash[:alert] = e.message
    end
    redirect_to users_url
  end

  private

  def set_user
    @user = User.where(id: params[:id]).first
  end

  def user_params
    params.require(:user).permit(:email,
                                 :password,
                                 :password_confirmation)
  end
end
