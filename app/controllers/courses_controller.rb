class CoursesController < ApplicationController

  def index
    @courses = current_user.courses
  end

  def show
    @course = Course.find(params[:id])
  end

  def courses_autocomplete
    courses = Course.all
    data = []
    courses.each do |course|
      title_hash = {}
      description_hash = {}
      title_hash["label"] = course.title
      title_hash["category"] = "Title"
      description_hash["label"] = course.description
      description_hash["category"] = "Description"
      data << title_hash
      data << description_hash
    end
    render json: {data: data}
  end

end
