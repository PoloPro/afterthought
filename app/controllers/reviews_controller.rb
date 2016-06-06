class ReviewsController < ApplicationController

  def index
    # current_user ? @reviews = current_user.reviews : @reviews = []
    @reviews = Review.all
  end

  def create
    review = Review.new(review_params)

    if review.save!
      redirect_to lecture_path
  end

  private

  def review_params
    params.require(:review).permit(:student_id, :lecture_id, :content)
  end

end