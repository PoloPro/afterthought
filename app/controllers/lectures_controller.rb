class LecturesController < ApplicationController

  def index
    # current_user ? @lectures = current_user.lectures : @lectures = []
    @lectures = current_user.lectures.sort_by { |lecture| lecture.finish_time }.reverse
  end

  def show
    set_current_user
    @lecture = Lecture.find(params[:id])
    @lecture_timer = LectureTimer.new(@lecture)
  end

  def new
    @lecture = Lecture.new
    @current_user = current_user
    @course = Course.find_by(id: params[:course_id])
  end

  def create
    @lecture = Lecture.new(lecture_params)
    finish_in_minutes = params[:lecture][:finish_time].to_i.minutes
    @lecture.finish_time = Time.now + finish_in_minutes
    if @lecture.save
      redirect_to course_lecture_path(@lecture.course, @lecture)
    else
      flash[:danger] = "Lecture create failed. Make sure all the forms are filled in. Titles must be 5 - 50 characters and description must be 10 - 150."
      @course = @lecture.course
      render :new
    end
  end

  def get_remaining_time
    if params[:id]
      lecture = Lecture.find(params[:id])
      lecture_timer = LectureTimer.new(lecture)
      render json: { lecture_timer: lecture_timer }
    end
  end

  private

  def set_current_user
    @current_user ||= current_user
  end

  def lecture_params
    params.require(:lecture).permit(:title, :description, :instructor_id, :course_id)
  end
end
