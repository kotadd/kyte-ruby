class Post < ApplicationRecord
  validates :content, {length: {maximum: 400}}
  validates :title, {presence: true, length: {maximum: 20}}
  validates :place, {length: {maximum: 50}}
  validates :date, {presence: true}
  validates :user_id, {presence: true}
  # validates :time_from, {presence: true}
  # validates :time_to, {presence: true}
  validate :time_check

  def user
    return User.find_by(id: self.user_id)
  end
  
  def genre
    return Genre.find_by(id: self.genre_id)
  end

  def time_check
    errors.add(:time_to, "End time should be later than start time.") unless
    if self.time_from
	    self.time_from < self.time_to
	end
  end 
end
