class PostTag < ApplicationRecord

  belongs_to :tag

  belongs_to :image, optional: true
  belongs_to :video, optional: true
  belongs_to :write, optional: true
  belongs_to :sound, optional: true

end
