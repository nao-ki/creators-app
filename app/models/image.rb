class Image < ApplicationRecord

  belongs_to :user

  has_one_attached :image, dependent: :destroy

  has_many :likes, dependent: :destroy
  has_many :likes_users, through: :likes, source: :user

  has_many :comments, dependent: :destroy


  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags


  def image_type
    if image.attached? == false
      errors.add(:image, 'error message')
    end
  end

  after_create do
    image = Image.find_by(id: self.id)
    tags  = self.content.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    tags.uniq.map do |t|
      tag = Tag.find_or_create_by(name: t.downcase.delete('#'))
      image.tags << tag
    end
  end

  before_update do
    image = Image.find_by(id: self.id)
    image.tags.clear
    tags = self.content.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    tags.uniq.map do |t|
      tag = Tag.find_or_create_by(name: t.downcase.delete('#'))
      image.tags << tag
    end
  end

end
