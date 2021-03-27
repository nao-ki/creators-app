class CommentsController < ApplicationController
  before_action :set_comment
  def create
    #投稿に紐づいたコメントを作成
    if @sentence
    @comment = @sentence.comments.build(comment_params)
    @comment.user_id = current_user.id
    @comment.save
    render :index
    elsif @sound
    @comment = @sound.comments.build(comment_params)
    @comment.user_id = current_user.id
    @comment.save
    render :index
    elsif @video
    @comment = @video.comments.build(comment_params)
    @comment.user_id = current_user.id
    @comment.save
    render :index
    else @image
    @comment = @image.comments.build(comment_params)
    @comment.user_id = current_user.id
    @comment.save
    render :index
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    render :index
  end

  private
  def comment_params
    params.require(:comment).permit(:text, :image_id, :sentence_id, :video_id, :sound_id, :user_id)
  end

  def set_comment
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

