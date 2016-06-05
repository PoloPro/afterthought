class LecturesController < ApplicationController

  def index
    # current_user ? @lectures = current_user.lectures : @lectures = []
    @lectures = Lecture.all
  end

  def show
    @lecture = Lecture.find(params[:id])
    @lecture_timer = LectureTimer.new(@lecture)
  end

end