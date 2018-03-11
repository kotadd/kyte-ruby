class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # before_action :set_current_user
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit(:username, :email, :password, :password_confirmation)
    end
    devise_parameter_sanitizer.permit(:sign_in) do |user_params|
      user_params.permit(:username, :password, :remember_me)
    end
    devise_parameter_sanitizer.permit(:account_update) do |user_params|
      user_params.permit(:username, :email)
    end
  end

  # def after_sign_in_path_for(resource)
  #   post_root
  # end

  # def set_current_user
  #   @current_user = User.find_by(id: session[:user_id])
  # end
  
  # def authenticate_user
  #   if @current_user == nil
  #     flash[:notice] = "ログインが必要です"
  #     redirect_to("/login")
  #   end
  # end
  
  # def forbid_login_user
  #   if @current_user
  #     flash[:notice] = "すでにログインしています"
  #     redirect_to("/posts/index")
  #   end
  # end

end
