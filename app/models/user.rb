class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :timeoutable, :omniauthable, omniauth_providers: [:twitter]


  # has_secure_password
  # VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  # VALID_WORKS_REGEX = /\A[\w+\-.]+@worksap+\.co+\.jp/i
  
  # validates :name, {presence: true, uniqueness: true}
  validates :username, {presence: true, uniqueness: true}
  # validates :email, {presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }}
  # validates :password, presence: true, length: {minimum: 8, maximum: 20, allow_blank: true}
  # validates :password, presence: true, on: :update

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
      post = Post.where(id: member.post_id).where('date >= ?', Date.today)
      if post.count > 0
        puts "joins!"
        joins.push(member)
      end
    end
    return joins
  end
  
  def joined
    members = Member.where(user_id: self.id)
    joined = []
    members.each do |member|
      post = Post.where(id: member.post_id).where('date < ?', Date.today)
      if post.count > 0
        puts "joined!"
        joined.push(member)
      end
    end
    return joined
  end

  def self.from_omniauth(auth)
    find_or_create_by(provider: auth["provider"], uid: auth["uid"]) do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.username = auth["info"]["nickname"]
    end
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"]) do |user|
        user.attributes = params
      end
    else
      super
    end
  end


end
