class HomeController < ApplicationController
  # class HomeController < UsersController
  before_action :move_to_index

  def index
    # @images = Image.order("RANDOM()").limit(6)

    # @images = Image.order("RAND()").limit(6)

    @image = Like.group(:image_id)
    @homeimage = Image.all.includes(:user).order("RAND()").limit(6)
    # @homeimage = Image.all.includes(:user).order("RANDOM()").limit(6)
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
