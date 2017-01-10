class RoomsController < ApplicationController
  before_action :require_authentication, only: [:new, :edit, :create, :update, :destroy]
  before_action :set_my_room, only: [:edit, :update, :destroy]

  def index
    @search_query = params[:q]

    rooms = Room.search(@search_query)

    @rooms = rooms.most_recent.map do |room|
      RoomPresenter.new(room, self, false)
    end

    # @rooms = Room.most_recent.map do |room|
    #   RoomPresenter.new(room, self, false)
    # end
  end

  def show
    room_model = Room.friendly.find(params[:id])
    @room = RoomPresenter.new(room_model, self)
  end

  def new
    @room = current_user.rooms.build
  end

  def edit
  end

  def create
    @room = current_user.rooms.build(room_params)

    if @room.save
      redirect_to @room, notice: t('flash.notice.room_created')
    else
      render :new
    end
  end

  def update
    if @room.update(room_params)
      redirect_to @room, notice: t('flash.notice.room_updated')
    else
      render :edit
    end
  end

  def destroy
    @room.destroy
    redirect_to rooms_url, notice: t('flash.notice.room_destroyed')
  end

  private
    def set_my_room
      @room = current_user.rooms.friendly.find(params[:id])
    end

    def room_params
      params.require(:room).permit(:title, :location, :description)
    end
end
