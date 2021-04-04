class Room < ApplicationRecord
# belongs_to :user
# belongs_to :entry

  has_many :entries
  has_many :direct_messages
  has_many :users, through: :entries
end
