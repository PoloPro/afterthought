class CoursesController < ApplicationController

  def index
    # current_user ? @courses = current_user.courses : @courses = []
    @courses = Course.all
  end

  def show
    @course = Course.find(params[:id])
  end

end