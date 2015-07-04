class Notifier < ApplicationMailer
  default_url_options[:host] = "localhost:3000"
  default from: "from@example.com"

  def password_reset(user)
    @user = user
    mail(to: @user.email,
         subject: "Reset Your Password")
  end
end
