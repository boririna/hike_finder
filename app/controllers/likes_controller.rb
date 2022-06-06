class LikesController < ApplicationController
  before_action :set_hike, only: %i[create]

  def index
    @likes = Like.all
    @my_likes = current_user.likes
  end

  def create
    @like = Like.new
    @like.hike = @hike
    @like.user = current_user

    if @like.save
      redirect_to hikes_path, notice: "Like created successfully"
    else
      redirect_to hikes_path, notice: "You already liked this hike"
    end
  end

  def destroy
    @like = Like.find(params[:id])
    @like.destroy
    redirect_to hikes_path
  end

  private

  def set_hike
    @hike = Hike.find(params[:hike_id])
  end
end
