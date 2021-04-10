class SentencesController < ApplicationController

  # before_action :move_to_index, except: [:index, :show]

  def index
    @quote =  ["  世の中の関節は外れてしまった
      あぁ、なんと呪われた因果か
      それを直すために生まれついたとは。
     「ハムレット」
      - Shakespeare （シェイクスピア） -",

      "吾輩は猫である。名前はまだ無い。
  「吾輩は猫である」
 - 夏目漱石 -",

      "恥の多い生涯を送ってきました。
  「人間失格」
  - 太宰治 - ",

          "何でもは知らないわよ。知ってることだけ。
  「化物語」
  - 羽川翼 -"
    ]

    @sentence = Sentence.includes(:user).order("created_at DESC").limit(5)
  end

  def new
    @sentence = Sentence.new
  end

  def create
    @sentence = Sentence.new(sentence_params)
    @sentence.user_id = current_user.id
     @sentence.save
    redirect_to action: :index
  end

  def destroy
    sentence = Sentence.find(params[:id])
    if sentence.user_id == current_user.id
      sentence.destroy
      redirect_to user_sentences_path(current_user.id)
    end
  end

  def edit
    @sentences = Sentence.find(params[:id])
    if @sentences.user_id != current_user.id
      redirect_to user_sentences_path(current_user.id)
    end
  end

  def update
    sentence = Sentence.find(params[:id])
    if sentence.user_id == current_user.id
      sentence.update(sentence_params)
      redirect_to user_sentences_path(current_user.id)
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
      params.require(:sentence).permit(:title, :summary, :content, :tag_ids)
    end

    # def move_to_index
    #   redirect_to action: :index unless user_signed_in?
    # end

end
