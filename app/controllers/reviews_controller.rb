class ReviewsController < ApplicationController
  before_action :set_hike, only: :create
  before_action :set_review, only: [ :edit, :update, :destroy ]

  def create
    @review = Review.new(review_params)
    @review.hike = @hike
    @review.user = current_user

    if @review.save
      redirect_to hike_path(@hike), notice: "Review created successfully"
    else
      redirect_to hike_path(@hike), notice: "Review not created, please write at least 10 characters and give a rating to make a review"
    end
  end

  def edit
    authorize @review
  end

  def update
    authorize @review
    if @review.update(review_params)
      redirect_to hike_path(@review.hike)
    else
      render "hikes/show"
    end

  end

  def destroy
    authorize @review
    @review.destroy
    redirect_to hike_path(@review.hike)

  end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end

  def set_hike
    @hike = Hike.find(params[:hike_id])
  end

  def set_review
    @review = Review.find(params[:id])
  end
end
