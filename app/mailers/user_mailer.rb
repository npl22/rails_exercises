class UserMailer < ApplicationMailer
  def welcome_email(user,url)
    @user = user
    @url = url
    mail(to: user.email, subject: "Welcome!!")
  end
end
