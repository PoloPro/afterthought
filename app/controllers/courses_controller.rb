class CoursesController < ApplicationController
  before_action :set_current_user

  def index
    # current_user ? @courses = current_user.courses : @courses = []
    @courses = Course.all
  end

  def show
    @course = Course.find(params[:id])
  end

  private

  def set_current_user
    @current_user = current_user
  end

end