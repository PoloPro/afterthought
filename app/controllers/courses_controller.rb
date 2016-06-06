class CoursesController < ApplicationController

  def index
    @courses = current_user.courses
  end

  def show
    @course = Course.find(params[:id])
  end

  def get_courses

    @courses = Course.all
    data = {}

  end

end
