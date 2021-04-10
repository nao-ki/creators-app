class ImagesController < ApplicationController

  def new
    @image = Image.new
  end

  def index
    @images = Image.order("created_at DESC")
  end

  def create
    @image = Image.new(image_params)
    @image.user_id = current_user.id

    if @image.image.attached? == false
      @error = "画像ファイルを貼り付けてください"
      render :new
    else
      @image.save
      redirect_to action: :index
    end
  end


  def destroy
    image = Image.find(params[:id])
    if image.user_id == current_user.id
      image.destroy
      redirect_to user_images_path(current_user.id)
    end

  end


  def show
    @image = Image.find(params[:id])
    @user  = User.find(@image.user_id)
    @like = Like.new

    @comment = Comment.new
    @comments = @image.comments.order(created_at: :desc)

  end

  def edit
    @image = Image.find(params[:id])
  end

  def update
    @image = Image.find(params[:id])
    if @image.update params.require(:image).permit(:title, :content, :image)
    redirect_to user_images_path(current_user.id)
    end

  end

  private
  def image_params
    params.require(:image).permit(:title, :content, :image, :tag_ids)
  end

end
