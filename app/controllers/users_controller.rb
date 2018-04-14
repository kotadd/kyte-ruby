class UsersController < ApplicationController
  before_action :authenticate_user, {only: [:index, :show, :edit, :update]}
  before_action :forbid_login_user, {only: [:new, :create, :login_form, :login]}
  before_action :ensure_correct_user, {only: [:edit, :update, :password, :update_password]}
  
  def index
    @users = User.all
  end
  
  def show
    @user = User.find_by(id: params[:id])
    @posts = @user.posts
    @likes = @user.likes
    @joins = @user.joins
    @joined = @user.joined
  end
    
  def create
    @user = User.new(
      name: params[:name],
      email: params[:email],
      # image_name: "default_user.jpg",
      password: params[:password]
    )
    respond_to do |format|
      if params[:password] != params[:password_confirmation] 
        @error_message = "パスワードと確認用のパスワードが一致していません"
        @name = params[:name]
        @email = params[:email]
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
        # render("users/new")
      elsif params[:password].length < 8
       @error_message = "パスワードは8文字以上で入力してください"
        @name = params[:name]
        @email = params[:email]
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }

      elsif @user.save
        session[:user_id] = @user.id

        # TODO 登録を行った人にメールを送る場合はここを有効化する
        # UserMailer.welcome_email(@user).deliver_later
 
        format.html { redirect_to("/posts/index", notice: 'ユーザー登録が完了しました') }
        format.json { render json: @user, status: :created, location: @user }
        # flash[:notice] = "ユーザー登録が完了しました"
        # redirect_to("/users/#{@user.id}")
      else
        # flash.now[:notice] = "すでに登録されているユーザーです"
        # @error_message = "ユーザー名またはメールアドレスが間違っています"
        @name = params[:name]
        @email = params[:email]
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
        # render("users/new")
      end
    end
  end
  
  def new
    @user = User.new
  end

  def edit
    @user = User.find_by(id: params[:id])
  end
  
  def password
    @user = User.find_by(id: params[:id])
  end

  def forgot_password_form
  end

  def forgot_password
    @user = User.find_by(email: params[:email])
    respond_to do |format|

      if @user
        # user_id, expire_at = Rails.application.message_verifier(:password_reset).verify(params[:token])

        UserMailer.reset_password(@user).deliver_later
        format.html { redirect_to("/login", notice: 'パスワード変更用のメールが送信されました') }
        format.json { render json: @user, status: :unprocessable_entity }

        # rescue ActiveSupport::MessageVerifier::InvalidSignature
        # invalid token
      else
        @error_message = 'このメールアドレスは登録されていません'
        format.html { render action: 'forgot_password_form' }
        format.json { render json: 'このメールアドレスは登録されていません', status: :unprocessable_entity }

      end

    end

  end

  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.email = params[:email]
    
    if params[:image]
      # @user.image_name = "#{@user.id}.jpg"
      # image = params[:image]
      # File.binwrite("public/user_images/#{@user.image_name}", image.read)
      
      @user.avatar = params[:image]
    end
    
    if @user.save
      flash[:notice] = "ユーザー情報を編集しました"
      redirect_to("/users/#{@user.id}/edit")
    else
      render("users/edit")
    end
  end

  def update_password
    @user = User.find_by(id: params[:id])
    if @user && @user.authenticate(params[:current_password])
      if params[:new_password] != params[:confirm_password]
       @error_message = "新しく入力されたパスワードが一致していません"
        render("users/password")
      elsif params[:new_password].length < 8
       @error_message = "パスワードは8文字以上で入力してください"
        render("users/password")        
      else
        @user.password = params[:new_password]    
        if @user.save
          flash[:notice] = "パスワードを更新しました"
          redirect_to("/users/#{@user.id}/password")
        else
          render("users/password")
        end
      end
    else
       @error_message = "現在のパスワードが間違っています"        
        render("users/password")
    end
  end
    
  def login_form
  end

  def login
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました"
      redirect_to("/users/#{@user.id}/joins")
    else
      @error_message = "メールアドレスまたはパスワードが間違っています"
      @email = params[:email]
      render("users/login_form")
    end
  end
  
  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to("/")
  end
  
  def likes
    @user = User.find_by(id: params[:id])
    @posts = @user.posts
    @likes = @user.likes
    @joins = @user.joins
    @joined = @user.joined
  end

  def joins
    @user = User.find_by(id: params[:id])
    @posts = @user.posts
    @likes = @user.likes
    @joins = @user.joins
    @joined = @user.joined

    # p Date.today.beginning_of_week(:monday)
    # p Date.today.beginning_of_week(:tuesday) 
    # p Date.today.beginning_of_week(:wednesday) 
    # p Date.today.beginning_of_week(:thursday) 
    # p Date.today.beginning_of_week(:friday) 
    # p Date.today.beginning_of_week(:saturday) 
    # p Date.today.beginning_of_week(:sunday)+7

    @today = Date.today

    @weekDaysMap = { 
      Date.today.beginning_of_week(:monday)     => "今週の月曜日",
      Date.today.beginning_of_week(:tuesday)    => "今週の火曜日",
      Date.today.beginning_of_week(:wednesday)  => "今週の水曜日",
      Date.today.beginning_of_week(:thursday)   => "今週の木曜日",
      Date.today.beginning_of_week(:friday)     => "今週の金曜日",
      Date.today.beginning_of_week(:saturday)   => "今週の土曜日",
      Date.today.beginning_of_week(:sunday)     => "今週の日曜日", 

      Date.today.beginning_of_week(:monday)    + 7   => "来週の月曜日",
      Date.today.beginning_of_week(:tuesday)   + 7   => "来週の火曜日",
      Date.today.beginning_of_week(:wednesday) + 7   => "来週の水曜日",
      Date.today.beginning_of_week(:thursday)  + 7   => "来週の木曜日",
      Date.today.beginning_of_week(:friday)    + 7   => "来週の金曜日",
      Date.today.beginning_of_week(:saturday)  + 7   => "来週の土曜日",
      Date.today.beginning_of_week(:sunday)    + 7   => "来週の日曜日", 
    }

    # p "--------------------"
    # p "@today"
    # p @today
    # p "weekDaysMap[@today]"
    # p weekDaysMap[@today-2]
    # p "--------------------"

  end
  
  def joined
    @user = User.find_by(id: params[:id])
    @posts = @user.posts
    @likes = @user.likes
    @joins = @user.joins
    @joined = @user.joined
  end

  def ensure_correct_user
    if @current_user.id != params[:id].to_i
      flash[:notice] = "権限がありません"
      redirect_to("/posts/index")
    end
  end
  
end
