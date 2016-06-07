class CoursesController < ApplicationController
  before_action :set_current_user

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
      label_type = course.title
      autocomplete_data(data, label_type, "Title")
    end
    courses.each do |course|
      label_type = course.description
      autocomplete_data(data, label_type, "Description")
    end
    render json: {data: data}
  end

  def display_joinable_courses
    search_term = params["data"]
    info = CoursesHelpers.get_course_info(search_term)
    render json: course_data(info)
  end

  def check_course_permissions
    course_id = params["course_id"].to_i
    if CoursesHelpers.not_course_instructor?(course_id, current_user)
      render json: {prompt: "Enter course password:"}
    else
      render json: {alert: "You've already joined that course"}
    end
  end

  def add_course
    course = Course.find_by(id: params["course_id"].to_i)
    if course && course.authenticate(params["password"])
      current_user.courses << course
      info = CoursesHelpers.put_info_into_hash(course)
      render json: course_data(info)
    else
      render json: {alert: "Password failed"}
    end
  end

  def remove_course
    course = Course.find_by(title: params["course_title"])
    current_user.courses.delete(course)
    current_user.save
    render json: {
      stringifyTitle: course.title.parameterize,
      title: course.title
    }
  end

  private
  def autocomplete_data(data, label_type, category_type)
    title_hash = {}
    title_hash["label"] = label_type
    title_hash["category"] = category_type
    data << title_hash
  end

  def course_data(info)
    {slugified_title: info["course_title"].parameterize,
    title: info["course_title"],
    description: info["course_description"],
    courseId: info["course_id"],
    coursePath: info["course_path"],
    courseStudents: info["course_students"]}
  end

  def set_current_user
    @current_user = current_user
  end
end
