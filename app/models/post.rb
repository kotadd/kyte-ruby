class Post < ApplicationRecord
  validates :content, {length: {maximum: 400}}
  validates :title, {presence: true, length: {maximum: 20}}
  validates :place, {length: {maximum: 50}}
  validates :date, {presence: true}
  validates :user_id, {presence: true}
  
  def user
    return User.find_by(id: self.user_id)
  end
  
end
