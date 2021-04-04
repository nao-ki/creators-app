class Tag < ApplicationRecord
  has_many :post_tags

  has_many :images, through: :post_tags
  has_many :sounds, through: :post_tags
  has_many :sentences, through: :post_tags
  has_many :videos, through: :post_tags
end
