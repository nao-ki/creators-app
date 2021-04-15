class SoundsController < ApplicationController
  def new
    @sound = Sound.new
  end

  def index
    @sounds = Sound.includes(:user).order("created_at DESC")
  end

  def edit
    @sound = Sound.find(params[:id])
  end

  def update
    @sound = Sound.find(params[:id])
    if current_user.id == @sound.user_id
      @sound.update(sound_params)
      # flash[:notice] = "投稿完了"
    redirect_to user_sounds_path(current_user.id)
    end
  end


  def create
    @sound = Sound.new(sound_params)
    @sound.user_id = current_user.id
    if @sound.sound.attached?
      if @sound.save
        redirect_to action: :index
      end
    else
      @errors = "音声ファイルを貼り付けてください"
      render action: :new
    end

  end

  def destroy
    sound = Sound.find(params[:id])
    if sound.user_id == current_user.id
      sound.destroy
    end
    redirect_to user_sounds_path(current_user.id)
  end

  def show
    @sound = Sound.find(params[:id])
    @like = Like.new
    @comment = Comment.new
    @comments = @sound.comments.order(created_at: :desc)
  end

  private
  def sound_params
    params.require(:sound).permit(:title, :content, :sound, :tag_ids)
  end
end
