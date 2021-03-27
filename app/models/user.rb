class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
 devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

has_many :sentences,  dependent: :destroy
has_many :comments

validates :nickname, presence: :true

has_one :icon
#ユーザアイコン
has_one_attached :icon, dependent: :destroy
has_many_attached :icons, dependent: :destroy
#ユーザアイコン

#音関連
has_one_attached :sound, dependent: :destroy
has_many_attached :sounds, dependent: :destroy
#音関連

#動画関連
has_one_attached :video, dependent: :destroy
has_many_attached :videos, dependent: :destroy
#動画関連

#画像関連
has_one_attached :image, dependent: :destroy
has_many_attached :images, dependent: :destroy
#画像関連

# いいね関連
has_many :likes, dependent: :destroy
has_many :likes_sentences, through: :likes, source: :sentence
has_many :likes_images, through: :likes, source: :image
has_many :likes_videos, through: :likes, source: :video
has_many :likes_sounds, through: :likes, source: :sound
# いいね関連

has_many :following_relationships, foreign_key: "follower_id", class_name: "Relationship",  dependent: :destroy
has_many :following, through: :following_relationships

has_many :follower_relationships, foreign_key: "following_id", class_name: "Relationship", dependent: :destroy
has_many :followers, through: :follower_relationships


#フォローしているかを確認するメソッド
def following?(user)
  following_relationships.find_by(following_id: user.id)
end

#フォローするときのメソッド
def follow(user)
  following_relationships.create!(following_id: user.id)
end

#フォローを外すときのメソッド
def unfollow(user)
  following_relationships.find_by(following_id: user.id).destroy
end

def already_liked?(sentence)
  self.likes.exists?(sentence_id: sentence.id)
end

end