class UserMailer < ApplicationMailer
  default from: 'kyteapp2018@example.com'
 
  def welcome_email(user)
    @user = user
    # @url  = 'http://localhost:3000/login'
    @url  = 'https://peaceful-harbor-31694.herokuapp.com/login'
    mail(to: @user.email, subject: 'Kyteへようこそ')
  end
end
