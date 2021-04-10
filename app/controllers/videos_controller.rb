class VideosController < ApplicationController

def new
  @video = Video.new
end

def index
  @videos = Video.includes(:user).order("created_at DESC")
end

def edit
  @video = Video.find(params[:id])
end

def update
  @video = Video.find(params[:id])
  if current_user.id == @video.user_id
    @video.update(video_params)
  redirect_to user_videos_path(current_user.id)
  end
end

def create
@video = Video.new(video_params)
@video.user_id = current_user.id
if @video.video.attached?
  if @video.save
    redirect_to action: :index
  end
else
  @errors = "動画ファイルを貼り付けてください"
  render action: :new
end

end

def destroy
  video = Video.find(params[:id])
  if video.user_id == current_user.id
    video.destroy
  end
  redirect_to action: :index
end

def show
  @video = Video.find(params[:id])
  @comment = Comment.new
  @comments = @video.comments.order(created_at: :desc)
end

  private
  def video_params
    params.require(:video).permit(:title, :content, :video, :tag_ids)
  end
end