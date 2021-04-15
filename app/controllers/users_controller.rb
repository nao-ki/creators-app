class UsersController < ApplicationController

  before_action :chatinfo, only: [:images, :videos, :sounds, :sentences ]


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
      @sentences = @user.sentences

      @image = Image.where(user_id: @user.id).order("created_at DESC")
      @video = Video.where(user_id: @user.id).order("created_at DESC")
      @sound = Sound.where(user_id: @user.id).order("created_at DESC")
      @sentence = Sentence.where(user_id: @user.id).order("created_at DESC")
      @allworks = (@image + @video + @sound + @sentence).sort_by{|record| record.created_at}.reverse!

    @currentUserEntry = Entry.where(user_id: current_user.id)
    @userEntry=Entry.where(user_id: @user.id)
    unless @user.id == current_user.id
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id then
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end

      unless @isRoom
        @room = Room.new
        @entry = Entry.new
    end
  end

 end

  def following
    @user  = User.find(params[:id])
    @users = @user.following

  end

  def followers
    @user  = User.find(params[:id])

    @users = @user.follower_relationships
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
  @sentence = Sentence.where(user_id: @fuser.ids).order("created_at DESC")

  @works = (@video + @image + @sound + @sentence).sort_by{|record| record.created_at}.reverse!

end

    def images
      @usericon = Icon.find_by(user_id: @user.id)
      @images = Image.where(user_id: @user.id)
    end

    def videos
      @usericon = Icon.find_by(user_id: @user.id)
      @videos = Video.where(user_id: @user.id)
    end

    def sounds
      @usericon = Icon.find_by(user_id: @user.id)
      @sounds = Sound.where(user_id: @user.id)
    end

    def sentences
      @usericon = Icon.find_by(user_id: @user.id)
      @sentences = Sentence.where(user_id: @user.id)
    end

  private
  def user_params
    params.require(:user).permit(:email, :genre, :url_link, :introduction, :word)
  end

  def chatinfo
      @user = User.find(params[:user_id])
      @currentUserEntry = Entry.where(user_id: current_user.id)
      @userEntry=Entry.where(user_id: @user.id)
      unless @user.id == current_user.id
        @currentUserEntry.each do |cu|
          @userEntry.each do |u|
            if cu.room_id == u.room_id then
              @isRoom = true
              @roomId = cu.room_id
            end
          end
        end
        unless @isRoom
          @room = Room.new
          @entry = Entry.new
      end
    end
  end

end
