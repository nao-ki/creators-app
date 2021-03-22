class Like < ApplicationRecord
  belongs_to :user
  belongs_to :write, optional: true
  belongs_to :image, optional: true
  belongs_to :sound, optional: true
  belongs_to :video, optional: true

  # validates_uniqueness_of :write_id, scope: :user_id
  # validates_uniqueness_of :image_id, scope: :user_id
  # validates_uniqueness_of :sound_id, scope: :user_id
  # validates_uniqueness_of :video_id, scope: :user_id

end
