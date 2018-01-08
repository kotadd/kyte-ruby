class PostsController < ApplicationController
  before_action :authenticate_user
  before_action :ensure_correct_user, {only: [:edit, :update, :destroy]}
  
  def index
    @posts = Post.all.order(created_at: :desc)
    @posts_skunk = Post.where(genre_id: 1)
    @posts_english = Post.where(genre_id: 2)
    @posts_party = Post.where(genre_id: 3)
    @posts_others = Post.where(genre_id: 4)
    
  end
  
  def show
    @post = Post.find_by(id: params[:id])
    @user = @post.user
    @likes_count = Like.where(post_id: @post.id).count

    # to show all the particapant images considering default_image.jpg
    @members = Member.where(post_id: @post.id)    
    @member_users = Array.new
    @members.each do |member|
      @member_users.push(member.user)
    end


    if @post.time_from
      if @post.time_from.min == 0
        @time_from = @post.time_from.hour.to_s + ":" + @post.time_from.min.to_s + "0"
      else
        @time_from = @post.time_from.hour.to_s + ":" + @post.time_from.min.to_s
      end
    end
    if @post.time_to
      if @post.time_to.min == 0
        @time_to = @post.time_to.hour.to_s + ":" + @post.time_to.min.to_s + "0"
      else
        @time_to = @post.time_to.hour.to_s + ":" + @post.time_to.min.to_s
      end
    end

  end
  
  def new
    @post = Post.new
    @genre = Genre.all

  end
  
  def create
    @post = Post.new(
      title: params[:title],
      date: params[:date],
      time_from: params[:time_from],
      time_to: params[:time_to],
      place: params[:place],
      budget: params[:budget],
      max_member: params[:max_member],
      genre_id: params[:genre_id],
      content: params[:content],
      user_id: @current_user.id
    )
    if @post.time_from
      @time_from = @post.time_from.hour.to_s + ":" + @post.time_from.min.to_s
    end
    if @post.time_to
      @time_to = @post.time_to.hour.to_s + ":" + @post.time_to.min.to_s
    end

    if params[:image]
      # 画像名称思いつかないので、一旦UUIDで
      @post.image_name = SecureRandom.uuid.to_s + ".jpg"
      image = params[:image]
      File.binwrite("public/post_images/#{@post.image_name}", image.read)
    end


    if @post.save
      flash[:notice] = "投稿を作成しました"
      @member = Member.new(user_id: @current_user.id, post_id: @post.id)
      @member.save
      redirect_to("/posts/index")
    else
      render("posts/new")
    end
  end
  
  def edit
    @post = Post.find_by(id: params[:id])
    if @post.time_from
      if @post.time_from.min == 0
        @time_from = @post.time_from.hour.to_s + ":" + @post.time_from.min.to_s + "0"
      else
        @time_from = @post.time_from.hour.to_s + ":" + @post.time_from.min.to_s
      end
    end
    if @post.time_to
      if @post.time_to.min == 0
        @time_to = @post.time_to.hour.to_s + ":" + @post.time_to.min.to_s + "0"
      else
        @time_to = @post.time_to.hour.to_s + ":" + @post.time_to.min.to_s
      end
    end
    @genre = Genre.all
  end
  
  def update
    @post = Post.find_by(id: params[:id])

    @post.title = params[:title]
    @post.date = params[:date]
    @post.place = params[:place]
    @post.time_from = params[:time_from]
    @post.time_to = params[:time_to]
    @post.budget = params[:budget]
    @post.max_member = params[:max_member]
    @post.genre_id = params[:genre_id]
    @post.content = params[:content]
    @post.user_id = @current_user.id

    if @post.time_from
      @time_from = @post.time_from.hour.to_s + ":" + @post.time_from.min.to_s
    end
    if @post.time_to
      @time_to = @post.time_to.hour.to_s + ":" + @post.time_to.min.to_s
    end

    if params[:image]
      # 画像名称思いつかないので、一旦UUIDで
      @post.image_name = SecureRandom.uuid.to_s + ".jpg"
      image = params[:image]
      File.binwrite("public/post_images/#{@post.image_name}", image.read)
    end

    if @post.save
      flash[:notice] = "投稿を編集しました"
      redirect_to("/posts/index")
    else
      render("posts/edit")
    end
  end
  
  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to("/posts/index")
  end
  
  def ensure_correct_user
    @post = Post.find_by(id: params[:id])
    if @post.user_id != @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to("/posts/index")
    end
  end
  
end
