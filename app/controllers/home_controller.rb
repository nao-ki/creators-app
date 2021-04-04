class HomeController < ApplicationController
  # class HomeController < UsersController
  before_action :move_to_index

  def index
    @images = Image.order("RANDOM()").limit(6)

    # @images = Image.order("RAND()").limit(6)

    @image = Like.group(:image_id)
    # @homeimage = Image.all.includes(:user).order("RAND()").limit(6)
    @homeimage = Image.all.includes(:user).order("RANDOM()").limit(6)
    @comment = Comment.new

    @like = Like.new

    @posts = Image.includes(:likes_users).sort {|a,b| b.likes_users.size <=> a.likes_users.size}

  end

  def slide
    # @images = Image.includes(:user).order("RANDOM()").limit(6)
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
