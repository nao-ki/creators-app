class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def edit
    @user  = User.find(params[:id])
    @icon = Icon.new
    @usericon = Icon.find_by(user_id: @user.id)
  end

  def update
    user = User.find(params[:id])

    if user.id == current_user.id
      user.update(user_params)
      redirect_to action: :show
    end

  end

  def show
      @user  = User.find(params[:id])
      @usericon = Icon.find_by(user_id: @user.id)
      @writes = @user.writes

      @image = Image.where(user_id: @user.id).order("created_at DESC")
      @video = Video.where(user_id: @user.id).order("created_at DESC")
      @sound = Sound.where(user_id: @user.id).order("created_at DESC")
      @write = Write.where(user_id: @user.id).order("created_at DESC")
      @allworks = (@image + @video + @sound + @write).sort_by{|record| record.created_at}.reverse!
  end

  def following
    #@userがフォローしているユーザー
    @user  = User.find(params[:id])
    @users = @user.following

  end

  def followers
    #@userをフォローしているユーザー
    @user  = User.find(params[:id])

    @users = @user.follower_relationships.includes(:writes)
  end

  def likes
    @user = User.find(params[:user_id])
    @likes = Like.where(user_id: @user.id).order("created_at DESC")
  end

def following_works
  @user = User.find(params[:user_id])
  @fuser = @user.following

  @video = Video.where(user_id: @fuser.ids).order("created_at DESC")
  @image = Image.where(user_id: @fuser.ids).order("created_at DESC")
  @sound = Sound.where(user_id: @fuser.ids).order("created_at DESC")
  @write = Write.where(user_id: @fuser.ids).order("created_at DESC")

  @works = (@video + @image + @sound + @write).sort_by{|record| record.created_at}.reverse!

end

    def images
      @user = User.find(params[:user_id])
      @usericon = Icon.find_by(user_id: @user.id)
      @images = Image.where(user_id: @user.id)
    end

    def videos
      @user = User.find(params[:user_id])
      @usericon = Icon.find_by(user_id: @user.id)
      @videos = Video.where(user_id: @user.id)
    end

    def sounds
      @user = User.find(params[:user_id])
      @usericon = Icon.find_by(user_id: @user.id)
      @sounds = Sound.where(user_id: @user.id)
    end

    def writes
      @user = User.find(params[:user_id])
      @usericon = Icon.find_by(user_id: @user.id)
      @writes = Write.where(user_id: @user.id)
    end

  private
  def user_params
    params.require(:user).permit(:email, :genre, :url_link, :introduction, :word)
  end
  def icon_params
    params.require(:icon).permit(:icon)
  end



end
