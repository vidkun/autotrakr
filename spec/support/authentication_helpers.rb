module AuthenticationHelpers
  def sign_in(user)
    controller.stub(:current_user).and_return(user)
    controller.stub(:user_id).and_return(user.id)
  end
end