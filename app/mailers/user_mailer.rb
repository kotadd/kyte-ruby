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

    # トークンを利用してやろうとしたが、パスワードをあらかじめ変更したほうが取り扱いが楽
    # token = Rails.application.message_verifier(:reset_password).generate([user.id, 1.day.since])
    # mail(to: @user.email, body: edit_password_reset_url(token))

    # @url  = 'http://localhost:3000/login'
    @url  = 'https://peaceful-harbor-31694.herokuapp.com/login'

    @password = SecureRandom.hex(10)
    @user.password = @password
    
    if @user.save
      # @url  = 'https://peaceful-harbor-31694.herokuapp.com/login'
      mail(to: @user.email, subject: 'Kyteのパスワード再設定を行いました')
    else 
      @error_message = 'パスワードの変更に失敗しました'
    end
  end

  def reminder(user)
    @user = user
    @url  = 'https://peaceful-harbor-31694.herokuapp.com/login'
    mail(to: @user.email, subject: '明日、参加予定のイベントがあります')
  end


end
