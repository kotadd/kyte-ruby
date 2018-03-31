class Post < ApplicationRecord
  validates :content, {length: {maximum: 400}}
  validates :title, {presence: true, length: {maximum: 20}}
  validates :place, {length: {maximum: 50}}
  # validates :date_from, {presence: true}
  validates :user_id, {presence: true}
  # validates :time_from, {presence: true}
  # validates :time_to, {presence: true}
  validate :time_check
  validate :date_check
  mount_uploader :image, ImageUploader

  def user
    return User.find_by(id: self.user_id)
  end
  
  def genre
    return Genre.find_by(id: self.genre_id)
  end

  def time_check
    errors.add(:time_to, "は開始時刻より後にしてください") unless
    if self.time_from
	    self.time_from < self.time_to
  	end
  end

  def date_check
    errors.add(:date_from, "は本日以降にしてください") unless
    if self.date_from
      Date.today <= self.date_from
    end

  end

end
