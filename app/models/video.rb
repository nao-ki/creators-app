class Video < ApplicationRecord
  belongs_to :user

  has_one_attached :video, dependent: :destroy

  has_many :likes, dependent: :destroy
  has_many :likes_users, through: :likes, source: :user

  has_many :comments

  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

  after_create do
    video = Video.find_by(id: self.id)
    tags  = self.content.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    tags.uniq.map do |t|
      tag = Tag.find_or_create_by(name: t.downcase.delete('#'))
      video.tags << tag
    end
  end

  before_update do
    video = Video.find_by(id: self.id)
    video.tags.clear
    tags = self.content.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    tags.uniq.map do |t|
      tag = Tag.find_or_create_by(name: t.downcase.delete('#'))
      video.tags << tag
    end
  end

end
