class HomeController < ApplicationController
  before_action :move_to_index

  def index
    @writes = Write.includes(:user).order("created_at DESC").limit(6)
    @images = Image.order("RAND()").limit(6)


    @userimage = Image.all.includes(:user).order("created_at DESC").limit(6)

    @videos = Video.includes(:user).order("created_at DESC").limit(6)

    @sounds = Sound.order("created_at DESC").limit(6)
    @comment = Comment.new
    @like = Like.new

    # @user = User.find(2)
  end

  def slide
    @images = Image.includes(:user).order("RANDOM()").limit(6)
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
