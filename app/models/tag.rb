class Tag < ApplicationRecord
  has_many :post_tags

  has_many :images, through: :post_tags
  has_many :sounds, through: :post_tags
  has_many :writes, through: :post_tags
  has_many :videos, through: :post_tags
end
