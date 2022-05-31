class ReviewsController < ApplicationController
  before_action :set_hike, only: :create

  def create
    @review = Review.new(review_params)
    @review.hike = @hike
    @review.user = current_user
    if @review.save
      redirect_to hike_path(@hike)
    else
      render hike_path(@hike)
    end
  end

  def update

  end

  def destroy

  end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end

  def set_hike
    @hike = Hike.find(params[:hike_id])
  end
end
