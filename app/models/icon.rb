class Icon < ApplicationRecord
  belongs_to :user

  has_one_attached :icon, dependent: :destroy
  has_many_attached :icons, dependent: :destroy
  has_many :likes
  has_many :likes_users, through: :videos, source: :user

end
