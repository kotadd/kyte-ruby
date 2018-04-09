class MembersController < ApplicationController
  before_action :authenticate_user

  def create
    post = Post.find_by(id: params[:post_id])
    members = Member.where(post_id: params[:post_id])

    if members.count < (post.max_member || 10000)
      @member = Member.new(user_id: @current_user.id, post_id: params[:post_id])
      @member.save
    else 
      flash[:notice] = "参加可能最大人数に達しました"
    end
      redirect_to("/posts/#{params[:post_id]}")
  end

  def destroy
    @member = Member.find_by(user_id: @current_user.id, post_id: params[:post_id])
    @member.destroy
    redirect_to("/posts/#{params[:post_id]}")
  end
  
end
