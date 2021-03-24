class WritesController < ApplicationController

  before_action :move_to_index, except: [:index, :show]

  def index
    @write = Write.includes(:user).order("created_at DESC")
  end

  def new
    @write = Write.new
  end

  def create
    @write = Write.new(write_params)
    if @write.user_id = current_user.id
    @write.save
    redirect_to action: :index
    end
  end

  def destroy
    write = Write.find(params[:id])
    if write.user_id == current_user.id
      write.destroy
    end
  end

  def edit
    @writes = Write.find(params[:id])
    if @writes.user_id != current_user.id
      redirect_to "/writes"
    end
  end

  def update
    write = Write.find(params[:id])
    if write.user_id == current_user.id
      write.update(write_params)
    end
  end

  def show
    @writes = Write.find(params[:id])
    @comment = Comment.new
    @comments = @writes.comments.order(created_at: :desc)
    @com = "write"
    @like = Like.new
  end

    private
    def write_params
      params.require(:write).permit(:title, :content, :summary, :tag_ids)
    end


    def move_to_index
      redirect_to action: :index unless user_signed_in?
    end


end
