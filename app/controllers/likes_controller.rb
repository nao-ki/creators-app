class LikesController < ApplicationController

  before_action :set_post

  def create

if @write
  @like = current_user.likes.new(write_id: @write.id)
  @like.save
  @likes = Like.where(write_id: @write.id)
elsif @image
  @like = Like.new(image_id: @image.id, user_id: current_user.id).save
  @likes = Like.where(image_id: @image.id)
elsif @sound
  @like = current_user.likes.new(sound_id: @sound.id)
  @like.save!

  @likes = Like.where(sound_id: @sound.id)
else @video
  @like = current_user.likes.new(video_id: @video.id)
  @like.save!
  @likes = Like.where(video_id: @video.id)
end
  end

  def destroy
    if @write
      @like = Like.find_by(write_id: @write.id, user_id: current_user.id).destroy!
      @likes = Like.where(write_id: @write.id)
    elsif @image
      @like = Like.find_by(image_id: @image.id, user_id: current_user.id).destroy!
      @likes = Like.where(image_id: @image.id)
    elsif @sound
      @like = Like.find_by(sound_id: @sound.id, user_id: current_user.id).destroy!
      @likes = Like.where(sound_id: @sound.id)
    else @video
      @like = Like.find_by(video_id: @video.id, user_id: current_user.id).destroy!
      @likes = Like.where(video_id: @video.id)
    end

  end

  private

  def like_params
    params.require(:like).permit(:write_id, :image_id, :video_id, :sound_id)
  end


  def set_post
    @path = request.fullpath
  if @path.include?("writes")
    @write = Write.find(params[:write_id])
    elsif @path.include?("images")
    @image = Image.find(params[:image_id])
    elsif @path.include?("video")
    @video = Video.find(params[:video_id])
    else @path.include?("sound")
    @sound = Sound.find(params[:sound_id])
  end

  end

end