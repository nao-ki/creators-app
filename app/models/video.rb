class Video < ApplicationRecord
  belongs_to :user

  has_one_attached :video, dependent: :destroy

  has_many :likes, dependent: :destroy
  has_many :likes_users, through: :videos, source: :user

  has_many :comments

  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

  after_create do
    #1.controller側でcreateしたTweetを取得
    video = Video.find_by(id: self.id)
    #2.正規表現を用いて、Tweetのtext内から『#○○○』の文字列を検出
    tags  = self.content.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    #3.mapメソッドでtags配列の要素一つ一つを取り出して、先頭の#を取り除いてDBへ保存する
    tags.uniq.map do |t|
      tag = Tag.find_or_create_by(name: t.downcase.delete('#'))
      video.tags << tag
    end
  end


end
