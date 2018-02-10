class PostsController < ApplicationController
  before_action :authenticate_user
  before_action :ensure_correct_user, {only: [:edit, :update, :destroy]}
  before_action :time_scheduler, {only: [:new, :edit, :create, :update]}
  
  def index
    # @posts = Post.all.order(created_at: :desc)
    @posts = []
    # @posts = Post.where('date >= ?', Date.today).where('date < ?', Time.current.since(5.days)).order(date: :asc, time_from: :asc)
    # 上のロジックをスッキリさせたものが下
    range = Date.today.beginning_of_day..Date.today.since(7.days).end_of_day
    post = Post.where(date: range).order(date: :asc, time_from: :asc)
    @first_post = true

    @posts.push(post)
    # @posts_skunk = Post.where(genre_id: 1).where('date >= ?', Date.today).order(date: :asc, time_from: :asc)
    # @posts_english = Post.where(genre_id: 2).where('date >= ?', Date.today).order(date: :asc, time_from: :asc)
    # @posts_party = Post.where(genre_id: 3).where('date >= ?', Date.today).order(date: :asc, time_from: :asc)
    # @posts_others = Post.where(genre_id: 4).where('date >= ?', Date.today).order(date: :asc, time_from: :asc)

    # TODO 一旦消えていくのが面倒なので。過去ログの取り扱い決まったら上のロジックに切り替え
    @genre = Genre.all
    @genre.each do |genre|
      @posts.push(Post.where(genre_id: genre.id).order(date: :asc, time_from: :asc))
    end


    # カードが全て表示されるか確認
    # @posts.each do |posts|
    #   posts.each do |post|
    #     puts post.title
    #   end
    # end

    # @posts_skunk = Post.where(genre_id: 1).order(date: :asc, time_from: :asc)
    # @posts_english = Post.where(genre_id: 2).order(date: :asc, time_from: :asc)
    # @posts_party = Post.where(genre_id: 3).order(date: :asc, time_from: :asc)
    # @posts_others = Post.where(genre_id: 4).order(date: :asc, time_from: :asc)

  end
  
  def detail
    @genre_id = params[:id].to_i
    if @genre_id == 0
      @future_posts = Post.where('date >= ?', Date.today).order(date: :asc, time_from: :asc)
      @genre_title = "開催日時の近い順（全てのポスト）"
    else
      @future_posts = Post.where(genre_id: @genre_id).where('date >= ?', Date.today).order(date: :asc, time_from: :asc)
      @genre_title = Genre.find_by(id: @genre_id).title
   end
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
    @genre = Genre.all
    @post = Post.new
    @new_button = true
  end
  
  def create
    puts params[:time_from]

    if params[:time_from]
      @time_from = params[:time_from]
    end
    if params[:time_to]
      @time_to = params[:time_to]
    end

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

    puts "check*********"
    puts @post.time_from


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
      @genre = Genre.all
      @new_button = true
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
    @new_button = true
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

    
    puts "*********ここをチェックする**********"
    puts @post.time_from
    puts "*********ここをチェックする**********"

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
      @genre = Genre.all
      @new_button = true
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
  
  def time_scheduler
    # white企業なので右の時間は不要ですね "0:00", "0:30", "1:00", "1:30", "2:00", "2:30", "3:00", "3:30", "4:00", "4:30", "5:00", "5:30", "6:00", "6:30", "7:00", "7:30", "8:00", "8:30", "9:00", 
    @time_ranges = ["9:30", "10:00", "10:30", "11:00", "11:30", "12:00", "12:30", "13:00", "13:30", "14:00", "14:30", "15:00", "15:30", "16:00", "16:30","17:00", "17:30", "18:00", "18:30", "19:00", "19:30", "20:00", "20:30", "21:00", "21:30", "22:00", "22:30", "23:00", "23:30"]
    @current_time = DateTime.now
    @current_hour = @current_time.hour
    @current_minute = @current_time.minute

    @target_hour = 0
    @target_minute = 0

    if @current_minute < 30
      @target_minute = 30
      @target_hour = @current_hour
      @target_from_time = @target_hour.to_s + ':' + @target_minute.to_s
      @target_to_time = (@target_hour+1).to_s + ':' + @target_minute.to_s
    else 
      @target_minute = 0
      @target_hour = @current_hour + 1
      @target_from_time = @target_hour.to_s + ':' + @target_minute.to_s + "0"
      @target_to_time = (@target_hour+1).to_s + ':' + @target_minute.to_s + "0"
    end

  end

end
