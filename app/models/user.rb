class User < ApplicationRecord
  has_secure_password
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  # VALID_WORKS_REGEX = /\A[\w+\-.]+@worksap+\.co+\.jp/i
  
  validates :name, {presence: true, uniqueness: true}
  validates :email, {presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }}

  
  def posts
    return Post.where(user_id: self.id)
  end
  
  def likes
    return Like.where(user_id: self.id)
  end

  def joins
    return Member.where(user_id: self.id)
  end

end
