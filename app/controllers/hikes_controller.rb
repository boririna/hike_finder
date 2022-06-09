class HikesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :set_hike, only: %i[show edit update destroy]

  def index
    # Search for hikes
    if params[:filter].present?
      @hikes = Hike.where(difficulty_level: params[:filter][:difficulty_level])
      @difficulty_level = params[:filter][:difficulty_level]
      @hikes = @hikes.where("ascent < ?", params[:filter][:altitude_gain]) if params[:filter][:altitude_gain].present?
      @hikes = @hikes.where("length < ?", params[:filter][:length]) if params[:filter][:length].present?
    else
      @hikes = Hike.all
    end

    # Search for like by user location and travel distance
    if params[:query_address].present? && params[:query_distance].present?
      # Select Hikes based on distance (km) from user_location
      @user_location = Geocoder.search(params[:query_address]).first.coordinates
      @hikes = Hike.near(@user_location, params[:query_distance].to_i)
      if @hikes[0] == nil
        @hikes = Hike.all
      end
    end

    # Create/pass hikes' markers to mapbox
    @markers = @hikes.map do | hike |
    {
      lat: hike.latitude,
      lng: hike.longitude,
      info_window: render_to_string(partial: "info_window", locals: { hike: hike }),
      image_url: helpers.asset_url("marker.png")
    }
    end

    # Add user marker to mapbox markers
    if params[:query_address].present? && params[:query_distance].present?
      @user_marker = {
        lat: @user_location[0],
        lng: @user_location[1],
        image_url: helpers.asset_url("user_marker.png")
      }
      @markers.push(@user_marker)
    end

    # Search for hikes by current user if logged in
    if current_user.present?
      @my_likes = current_user.likes
    else
      @my_likes = []
    end
  end

  def show
    @review = Review.new
    @reviews = @hike.reviews.all

    # Search for like by current user if logged in
    if current_user.present?
      @like = current_user.likes.find_by(hike: @hike)
    else
      @like = {}
    end
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
      if params[:hike][:photos].present?
        params[:hike][:photos].each do |photo|
          @hike.photos.attach(photo)
        end
      end
      redirect_to hike_path(@hike)
    else
      render :edit
    end
  end

  def destroy
    if current_user.present?
      authorize @hike
      @hike.destroy
    end
    redirect_to hikes_path
  end

  private

  def hike_params
    params.require(:hike).permit(:name, :description, :difficulty_level, :length, :ascent, :descent, :services, :latitude, :longitude, :dog_friendly, :hiking_time, :map_photo )
  end

  def set_hike
    @hike = Hike.find(params[:id])
  end
end
