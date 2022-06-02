

class HikesController < ApplicationController
<<<<<<< HEAD
  before_action :set_hike, only: [ :show, :edit, :update, :destroy ]
  def index
   if params[:query_address].present?
    locations = Hike.all.map { |h| [h.latitude, h.longitude] }

    # OpenRoute Service
    values = {"locations":locations, "range": params[:query_time].split(',').map(&:to_i) }

    headers = {
      :accept => 'application/json, application/geo+json, application/gpx+xml, img/png; charset=utf-8',
      :Authorization => '5b3ce3597851110001cf6248c4f7dde0d9df4d1587e4177cd11c2c6c',
      :Content-Type => 'application/json; charset=utf-8'
    }

    response = RestClient.post 'https://api.openrouteservice.org/v2/isochrones/driving-car', values, headers
    puts response

   else
    @hikes = Hike.all
   end
=======
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :set_hike, only: %i[show edit update destroy]

  def index
    # @hikes = Hike.all

    if params[:filter].present?
      @hikes = Hike.where(difficulty_level: params[:filter][:difficulty_level])
    else
      @hikes = Hike.all
    end
>>>>>>> 97b216bed751088940a48c88c1b8f7098749a90a

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
    params.require(:hike).permit(:name, :description, :difficulty_level, :length, :ascent, :descent, :services, :latitude, :longitude, :dog_friendly, photos: [] )
  end

  def set_hike
    @hike = Hike.find(params[:id])
  end
end
