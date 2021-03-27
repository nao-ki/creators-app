class Comment < ApplicationRecord
  belongs_to :user

  belongs_to :sentence, optional: true
  belongs_to :image, optional: true
  belongs_to :sound, optional: true
  belongs_to :video, optional: true

  validates :text, presence: true
end
