class SentencesController < ApplicationController

  before_action :move_to_index, except: [:index, :show]

  def index
    @sentence = Sentence.includes(:user).order("created_at DESC")
  end

  def new
    @sentence = Sentence.new
  end

  def create
    @sentence = Sentence.new(sentence_params)
    if @sentence.user_id = current_user.id
    @sentence.save
    redirect_to action: :index
    end
  end

  def destroy
    sentence = Sentence.find(params[:id])
    if sentence.user_id == current_user.id
      sentence.destroy
    end
  end

  def edit
    @sentences = Sentence.find(params[:id])
    if @sentences.user_id != current_user.id
      redirect_to "/sentences"
    end
  end

  def update
    sentence = Sentence.find(params[:id])
    if sentence.user_id == current_user.id
      sentence.update(sentence_params)
    end
  end

  def show
    @sentences = Sentence.find(params[:id])
    @comment = Comment.new
    @comments = @sentences.comments.order(created_at: :desc)
    @com = "sentence"
    @like = Like.new
  end


    private
    def sentence_params
      params.require(:sentence).permit(:title, :content, :summary, :tag_ids)
    end

    # private
    # def image_params
    #   params.require(:image).permit(:title, :content, :image, :tag_ids)
    # end

    def move_to_index
      redirect_to action: :index unless user_signed_in?
    end

end
