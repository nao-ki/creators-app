class Sound < ApplicationRecord
  belongs_to :user

  has_many :comments
  has_one_attached :sound, dependent: :destroy


  has_many :likes, dependent: :destroy
  has_many :likes_users, through: :likes, source: :user


  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

  after_create do
    sound = Sound.find_by(id: self.id)
    tags  = self.content.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    tags.uniq.map do |t|
      tag = Tag.find_or_create_by(name: t.downcase.delete('#'))
      sound.tags << tag
    end
  end

  before_update do
    sound = Sound.find_by(id: self.id)
    sound.tags.clear
    tags = self.content.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    tags.uniq.map do |t|
      tag = Tag.find_or_create_by(name: t.downcase.delete('#'))
      sound.tags << tag
    end
  end

end
