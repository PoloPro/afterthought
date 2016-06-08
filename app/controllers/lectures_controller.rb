class LecturesController < ApplicationController

  def index
    # current_user ? @lectures = current_user.lectures : @lectures = []
    @lectures = Lecture.all
  end

  def show
    set_current_user
    @lecture = Lecture.find(params[:id])
    @lecture_timer = LectureTimer.new(@lecture)
  end

  def get_remaining_time
    lecture = Lecture.find(params[:id])
    lecture_timer = LectureTimer.new(lecture)
    render json: { lecture_timer: lecture_timer }
  end

  private

  def set_current_user
    @current_user ||= current_user
  end

end