class Member < ApplicationRecord
  validates :user_id, {presence: true}
  validates :post_id, {presence: true}

  def user
    return User.find_by(id: self.user_id)
  end
end
