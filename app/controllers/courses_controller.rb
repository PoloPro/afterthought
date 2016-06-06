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
      title_hash["label"] = course.title
      title_hash["category"] = "Title"
      data << title_hash
    end
    courses.each do |course|
      description_hash = {}
      description_hash["label"] = course.description
      description_hash["category"] = "Description"
      data << description_hash
    end
    render json: {data: data}
  end

  def display_joinable_courses
    search_term = params["data"]
    course = Course.find_by(title: params["data"])
    course = Course.find_by(description: params["data"]) if course.nil?
    course_title = course.title
    course_description = course.description
    course_id = course.id
    course_path = course_path(course)
    render json: {
      title: course_title,
      description: course_description,
      courseId: course_id,
      coursePath: course_path
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

end
