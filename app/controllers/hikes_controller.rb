

class HikesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :set_hike, only: %i[show edit update destroy]

  def index
    # @hikes = Hike.all

    if params[:filter].present?
      @hikes = Hike.where(difficulty_level: params[:filter][:difficulty_level])
      @hikes = @hikes.where("ascent < ?", params[:filter][:altitude_gain]) if params[:filter][:altitude_gain].present?
      @hikes = @hikes.where("length < ?", params[:filter][:length]) if params[:filter][:length].present?
    else
      @hikes = Hike.all
    end

    @markers = @hikes.map do | hike |
      {
        lat: hike.latitude,
        lng: hike.longitude,
        info_window: render_to_string(partial: "info_window", locals: { hike: hike }),
        image_url: helpers.asset_url("marker.png")
      }
    end
  end

  def show
    @review = Review.new
    @reviews = @hike.reviews.all
    @like = Like.new
    @likes = @hike.likes.all
  end

  def new
    @hike = Hike.new
    authorize @hike
  end

  def create

    @hike = Hike.new(hike_params)
    if @hike.save
      redirect_to hikes_path
    else
      render :new
    end
    authorize @hike
  end

  def edit
    authorize @hike
  end

  def update
    authorize @hike
    if @hike.update(hike_params)
      redirect_to hike_path(@hike)
    else
      render :edit
    end
  end

  def destroy
    authorize @hike
    @hike.destroy
    redirect_to hikes_path
  end

  private

  def hike_params
    params.require(:hike).permit(:name, :description, :difficulty_level, :length, :ascent, :descent, :services, :latitude, :longitude, :dog_friendly, :hiking_time, :map_photo, photos: [], )
  end

  def set_hike
    @hike = Hike.find(params[:id])
  end
end
