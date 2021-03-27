class LikesController < ApplicationController

  before_action :set_post

  def create

if @sentence
  @like = current_user.likes.new(sentence_id: @sentence.id)
  @like.save
  @likes = Like.where(sentence_id: @sentence.id)
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
    if @sentence
      @like = Like.find_by(sentence_id: @sentence.id, user_id: current_user.id).destroy!
      @likes = Like.where(sentence_id: @sentence.id)
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
    params.require(:like).permit(:sentence_id, :image_id, :video_id, :sound_id)
  end


  def set_post
    @path = request.fullpath
  if @path.include?("sentences")
    @sentence = Sentence.find(params[:sentence_id])
    elsif @path.include?("images")
    @image = Image.find(params[:image_id])
    elsif @path.include?("video")
    @video = Video.find(params[:video_id])
    else @path.include?("sound")
    @sound = Sound.find(params[:sound_id])
  end

  end

end