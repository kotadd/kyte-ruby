class MembersController < ApplicationController
  # before_action :authenticate_user

  def create
    @member = Member.new(user_id: @current_user.id, post_id: params[:post_id])
    @member.save
    redirect_to("/posts/#{params[:post_id]}")
  end

  def destroy
    @member = Member.find_by(user_id: @current_user.id, post_id: params[:post_id])
    @member.destroy
    redirect_to("/posts/#{params[:post_id]}")
  end
  
end
