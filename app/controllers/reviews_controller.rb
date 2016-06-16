class ReviewsController < ApplicationController

  def index
    @reviews = current_user.reviews.sort_by { |review| review.created_at }
    @current_user = current_user
  end

  def create
    @review = Review.new(review_params)
    lecture_id = @review.lecture.id
    course_id = @review.lecture.course.id

    flash[:failure] = "Your review was not saved." unless @review.save
    render json: @review
  end

  def destroy
    review = Review.find(params[:id])
    lecture_id = review.lecture.id
    course_id = review.lecture.course.id

    flash[:failure] = "Your review was not deleted." unless review.destroy
    redirect_to course_lecture_path(course_id, lecture_id), status: 303
  end

  def make_review_anonymous
    @review = Review.find(params[:id])
    @review.anonymous = true
    render json: @review
  end

  def make_review_named
    @review = Review.find(params[:id])
    @review.anonymous = false
    render json: @review
  end

  private

  def review_params
    params.require(:review).permit(:student_id, :lecture_id, :content)
  end

end
