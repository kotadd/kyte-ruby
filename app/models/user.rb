class User < ApplicationRecord

  has_many :posts, dependent: :destroy

  has_secure_password
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  # VALID_WORKS_REGEX = /\A[\w+\-.]+@worksap+\.co+\.jp/i
  
  validates :name, {presence: true, uniqueness: true}
  validates :email, {presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }}
  # validates :password, presence: true, length: {minimum: 8, maximum: 20, allow_blank: true}
  # validates :password, presence: true, on: :update
  mount_uploader :avatar, AvatarUploader

  def posts
    post_ids = Member.where(user_id: self.id).pluck(:post_id)
    posts = Post.where("id IN (?)", post_ids).order(created_at: :desc)
    return posts
  end
  
  def likes
    post_ids = Member.where(user_id: self.id).pluck(:post_id)
    posts = Post.where("id IN (?)", post_ids).order(date_from: :desc, time_from: :desc)
    return posts
  end

  def joins
    post_ids = Member.where(user_id: self.id).pluck(:post_id)
    posts = Post.where("id IN (?)", post_ids).where('date_from >= ?', Date.today).order(date_from: :asc, time_from: :asc)
    return posts
  end
  
  def joined
    post_ids = Member.where(user_id: self.id).pluck(:post_id)
    posts = Post.where("id IN (?)", post_ids).where('date_from < ?', Date.today).order(date_from: :desc, time_from: :desc)
    return posts
  end


end
