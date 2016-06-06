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
    courses = Course.all
    course = courses.find_by(title: params["data"])
    course = courses.find_by(description: params["data"]) if course.nil?
    ##if course exists
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

  def add_course
    course = Course.find_by(id: 1)
    course_title = course.title
    course_description = course.description
    course_id = course.id
    course_path = course_path(course)
    course_students = course.students.count

    render json: {
      title: course_title,
      description: course_description,
      courseId: course_id,
      coursePath: course_path,
      courseStudents: course_students
    }
  end

end
