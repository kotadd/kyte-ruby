class UserMailer < ApplicationMailer
  default from: 'kyteapp2018@example.com'
 
  def welcome_email(user)
    @user = user
    # @url  = 'http://localhost:3000/login'
    @url  = 'https://peaceful-harbor-31694.herokuapp.com/login'
    mail(to: @user.email, subject: 'Kyteへようこそ')
  end

  def reset_password(user)
  	@user = user
    # token = Rails.application.message_verifier(:reset_password).generate([user.id, 1.day.since])
    # mail(to: @user.email, body: edit_password_reset_url(token))
    @url  = 'http://localhost:3000/reset_password'
    # @url  = 'https://peaceful-harbor-31694.herokuapp.com/reset_password'
    mail(to: @user.email, subject: 'Kyteのパスワード再設定を行います')
  end

end
