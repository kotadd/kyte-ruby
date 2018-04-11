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
    return Post.where(user_id: self.id)
  end
  
  def likes
    return Like.where(user_id: self.id)
  end

  def joins
    members = Member.where(user_id: self.id)
    joins = []
    members.each do |member|
      post = Post.where(id: member.post_id).where('date_from >= ?', Date.today)
      if post.count > 0
        # puts "joins!"
        joins.push(member)
      end
    end
    return joins
  end
  
  def joined
    members = Member.where(user_id: self.id)
    joined = []
    members.each do |member|
      post = Post.where(id: member.post_id).where('date_from < ?', Date.today)
      if post.count > 0
        # puts "joined!"
        joined.push(member)
      end
    end
    return joined
  end


end
