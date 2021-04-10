class Sentence < ApplicationRecord

  belongs_to :user
  has_many :comments
  has_many :likes, dependent: :destroy
  has_many :likes_users, through: :likes, source: :user

  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

  after_create do
    sentence = Sentence.find_by(id: self.id)
    tags  = self.summary.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    tags.uniq.map do |t|
      tag = Tag.find_or_create_by(name: t.downcase.delete('#'))
      sentence.tags << tag
    end
  end

  before_update do
    sentence = Sentence.find_by(id: self.id)
    sentence.tags.clear
    tags = self.summary.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    tags.uniq.map do |t|
      tag = Tag.find_or_create_by(name: t.downcase.delete('#'))
      sentence.tags << tag
    end
  end

end
