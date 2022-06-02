class LikesController < ApplicationController
  before_action :set_hike, only: %i[create destroy]

  def index
    @likes = Like.all
    @my_likes = current_user.likes
  end

  def create
    @like = Like.new
    @like.hike = @hike
    @like.user = current_user

    if @like.save
      redirect_to likes_path, notice: "like created successfully"
    else
      redirect_to hike_path(@hike), notice: "You already liked this"
    end
  end

  def destroy
    @like.destroy
    redirect_to likes_path
  end

  private

  def set_hike
    @hike = Hike.find(params[:hike_id])
  end
end
