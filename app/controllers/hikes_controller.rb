class HikesController < ApplicationController
  before_action :set_hike, only: [ :show, :edit, :update, :destroy ]

  def index
    @hikes = Hike.all
  end

  def show
  end

  def new
    @hike = Hike.new
  end

  def create
    @hike = Hike.new(hike_params)
    if @hike.save
      redirect_to hikes_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @hike.update(hike_params)
      redirect_to hike_path(@hike)
    else
      render :edit
    end
  end

  def destroy
    @hike.destroy
    redirect_to hikes_path
  end

  private

  def hike_params
    params.require(:hike).permit(:name, :description, :difficulty_level, :length, :ascent, :descent, :services, :dog_friendly)
  end

  def set_hike
    @hike = Hike.find(params[:id])
  end
end