class HomeController < ApplicationController
  # class HomeController < UsersController
  before_action :move_to_index

  def index

    @image = Like.group(:image_id)

    @comment = Comment.new

    @like = Like.new

    @likedImages = Image.includes(:likes_users).limit(5).sort {|a,b| b.likes_users.size <=> a.likes_users.size}

    @likedSounds = Sound.includes(:likes_users).limit(6).sort {|a,b| b.likes_users.size <=> a.likes_users.size}

    @likedVideos = Video.includes(:likes_users).limit(6).sort {|a,b| b.likes_users.size <=> a.likes_users.size}

    @likedSentences = Sentence.includes(:likes_users).limit(6).sort {|a,b| b.likes_users.size <=> a.likes_users.size}

  end

  def about

  end

  private
  def move_to_index
    unless user_signed_in?
      redirect_to new_user_session_path
    end
  end

end
