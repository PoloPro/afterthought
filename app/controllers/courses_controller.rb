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
    render json: {
      title: info["course_title"],
      description: info["course_description"],
      courseId: info["course_id"],
      coursePath: info["course_path"]
    }
  end

  def check_course_permissions
    course = Course.find_by(id: params["course_id"].to_i)
    course_instructors = course.instructors
    if !course_instructors.include? (current_user)
      render json: {prompt: "Enter course password:"}
    else
      render json: {alert: "You've already joined that course"}
    end
  end

  def add_course
    course = Course.find_by(id: params["course_id"].to_i)
    if course && course.authenticate(params["password"])
      current_user.courses << course
      course_title = course.title
      course_description = course.description
      course_id = course.id
      course_path = course_path(course)
      course_students = course.students.count

      render json: {
        slugified_title: course_title.parameterize,
        title: course_title,
        description: course_description,
        courseId: course_id,
        coursePath: course_path,
        courseStudents: course_students
      }
    else
      render json: {alert: "Password failed"}
    end
  end

  def remove_course
    course = Course.find_by(title: params["course_title"])
    current_user.courses.delete(course)
    current_user.save
    render json: {courseTitle: course.title.parameterize}
  end

  private
  def autocomplete_data(data, label_type, category_type)
    title_hash = {}
    title_hash["label"] = label_type
    title_hash["category"] = category_type
    data << title_hash
  end

  def set_current_user
    @current_user = current_user
  end
end
