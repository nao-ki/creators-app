class HashtagRelationship < ApplicationRecord
  belongs_to :image
  belongs_to :hashtag
  with_options presence: true do
    validates :image_id
    validates :hashtag_id
  end
end
