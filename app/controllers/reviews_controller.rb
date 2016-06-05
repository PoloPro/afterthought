class ReviewsController < ApplicationController

  def index
    # current_user ? @reviews = current_user.reviews : @reviews = []
    @reviews = Review.all
  end

end