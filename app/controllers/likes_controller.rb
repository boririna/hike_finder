class LikesController < ApplicationController
  before_action :set_like, only: [:show, :edit, :update, :destroy]

  def index
    @likes = Like.all
  end

  def show
  end

  def new
    @hike = Hike.find(params[:hike_id])
    @like = Like.new
  end

  def create
    @hike = Hike.find(params[:hike_id])
    @like = Like.new(like_params)
    @like.user = current_user
    if @like.save
      redirect_to likes_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @like.update(like_params)
      redirect_to like_path(@like)
    else
      render :edit
    end
  end

  def destroy
    @like.destroy
    redirect_to likes_path
  end

  private
    def like_params
      params.require(:like).permit(:hike_id)
    end

    def set_like
      @like = Like.find(params[:id])
    end

end
