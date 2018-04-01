class LikesController < ApplicationController
  before_action :authenticate_user

  def create
    @like = Like.new(user_id: @current_user.id, post_id: params[:post_id])
    @like.save
    # @likes_count = Like.where(post_id: params[:post_id]).count
    flash[:notice] = "お気に入りに登録しました"
    redirect_to("/posts/#{params[:post_id]}")
  end

  def destroy
    @like = Like.find_by(user_id: @current_user.id, post_id: params[:post_id])
    @like.destroy
    flash[:notice] = "お気に入りから削除しました"
    # @likes_count = Like.where(post_id: params[:post_id]).count
    redirect_to("/posts/#{params[:post_id]}")
  end

  def create_index
    @like = Like.new(user_id: @current_user.id, post_id: params[:post_id])
    @like.save
    flash[:notice] = "お気に入りに登録しました"
    redirect_to("/posts/index")
  end

  def destroy_index
    @like = Like.find_by(user_id: @current_user.id, post_id: params[:post_id])
    @like.destroy
    flash[:notice] = "お気に入りから削除しました"
    redirect_to("/posts/index")
  end
  
end
