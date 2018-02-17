class PagesController < ApplicationController

  before_action :forbid_login_user, {only: [:top]}
  def about   
	 @user = User.new
  end

  def top
    @genre = Genre.all
	@user = User.new
    @posts = Post.where('date >= ?', Date.today).order(date: :asc, time_from: :asc).limit(10)

    # strftime('%H:%M')で全部解決だった。
    # @time_from_arr = []
    # @time_to_arr = []
    # @posts.each do |post|
    #   if post.time_from
    #     if post.time_from.min == 0
    #       @time_from_arr.push(post.time_from.hour.to_s + ":" + post.time_from.min.to_s + "0")
    #     else
    #       @time_from_arr.push(post.time_from.hour.to_s + ":" + post.time_from.min.to_s)
    #     end
    #   end
    #   if post.time_to
    #     if post.time_to.min == 0
    #       @time_to_arr.push(post.time_to.hour.to_s + ":" + post.time_to.min.to_s + "0")
    #     else
    #       @time_to_arr.push(post.time_to.hour.to_s + ":" + post.time_to.min.to_s)
    #     end
    #   end
    # end
    # @card_count = 0
  end

end
