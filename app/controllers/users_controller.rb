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
      image_name: "default_user.jpg",
      password: params[:password]
    )
    if params[:password] != params[:password_confirmation] 
      @error_message = "パスワードと確認用のパスワードが一致していません"
      @name = params[:name]
      @email = params[:email]
      render("users/new")
    elsif @user.save
      session[:user_id] = @user.id
      flash[:notice] = "ユーザー登録が完了しました"
      redirect_to("/users/#{@user.id}")
    else
      # flash.now[:notice] = "すでに登録されているユーザーです"
      # @error_message = "ユーザー名またはメールアドレスが間違っています"
      @name = params[:name]
      @email = params[:email]
      render("users/new")
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

  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.email = params[:email]
    
    if params[:image]
      @user.image_name = "#{@user.id}.jpg"
      image = params[:image]
      File.binwrite("public/user_images/#{@user.image_name}", image.read)
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
      redirect_to("/posts/index")
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
