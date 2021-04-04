class RoomsController < ApplicationController
  before_action :authenticate_user!
  def show
    @room = Room.find(params[:id])
    #present?の戻り値は真偽値。よって、trueの場合、
    if Entry.where(:user_id => current_user.id, :room_id => @room.id).present?
      @direct_messages = @room.direct_messages
      @entries = @room.entries
    else
      redirect_back(fallback_location: root_path)
    end

    @entry = Entry.where(room_id: @room.id)
    @entry.each do |e|
      if e.user_id != current_user.id
        @user = e.user_id
        @chatuser = User.find(@user)
        @cuicon = Icon.find_by(user_id: @chatuser.id)
      end
    end
  end

  def index
      @entry = Entry.where(user_id: current_user.id)
  end

  def create
    @room = Room.create(:name => "DM")
    @entry1 = Entry.create(:room_id => @room.id, :user_id => current_user.id)
    @entry2 = Entry.create(params.require(:entry).permit(:user_id, :room_id).merge(:room_id => @room.id))
    redirect_to room_path(@room.id)
  end
end
