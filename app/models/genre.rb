class Genre < ApplicationRecord
  validates :title, {presence: true, uniqueness: true}
end
