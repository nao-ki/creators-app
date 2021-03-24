class IconsController < ApplicationController

  def new
    @icon = Icon.new
  end

  def create
    Icon.create(icon: icon_params[:icon], user_id: current_user.id)
    redirect_to user_path(current_user.id)
  end

  def show
    # @icon = find(params[:id])
    @icons = Icon.find_by(user_id: params[:id])
  end

  def edit

    @icon = Icon.find_by(user_id: params[:id])
    if @icon.user_id != current_user.id
      redirect_to root_path
    end
  end

  def update
    @icon = Icon.find(params[:id])
    @icon.update(icon: icon_params[:icon])
    # params.require(:icon).permit(:icon) # POINT
    redirect_to user_path(current_user.id)
  end

private
  def icon_params
    params.require(:icon).permit(:icon)
  end
end
