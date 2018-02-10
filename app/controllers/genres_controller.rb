class GenresController < ApplicationController

  def index
    @genre = Genre.all
    @genre_create = true
  end

  def new
    @genre = Genre.new
    @new_button = true
  end

  def create
    @genre = Genre.new(
      title: params[:title]
    )
    
    if @genre.save
      flash[:notice] = "ジャンルの追加が完了しました"
      redirect_to("/index")
    else
      if Genre.find_by(title: @genre.title) != nil
        @error_message = "すでに登録されているジャンルです"
      else
        @error_message = "ジャンルを入力してください"
      end
      # flash.now[:notice] = "すでに登録されているユーザーです"
      @title = params[:title]
      @new_button = true
      render("genres/new")
    end

  end

  def edit
    @genre = Genre.find_by(id: params[:id])
  end
  
  def update
    @genre = Genre.find_by(id: params[:id])
    
    @genre.title = params[:title]


    
    if @genre.save
      flash[:notice] = "ジャンル情報を編集しました"
      redirect_to("/genres/index")
    else
      render("genres/edit")
    end
  end

end