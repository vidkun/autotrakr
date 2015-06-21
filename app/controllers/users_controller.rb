class UsersController < ApplicationController
  # before_action :authenticate_user!, except: [:new, :create]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to users_url,
                  notice: "User #{@user.name} was successfully created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to users_url,
                  notice: "User #{@user.name} was successfully updated."
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
      flash[:notice] = "User #{user.name} deleted!"
    rescue StandardError => e
      flash[:notice] = e.message
    end
    redirect_to users_url
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
  params.require(:user).permit(:username,
                               :first_name,
                               :last_name,
                               :email,
                               :password,
                               :password_confirmation)
  end
end
