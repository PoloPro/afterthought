class CoursesController < ApplicationController
  before_action :set_current_user

  def index
    @courses = current_user.courses
  end

  def show
    @course = Course.find(params[:id])
    @lectures = @course.lectures
    @students = @course.students
    set_current_user
  end

  def new
    instructor_access_only
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)
    @course.title = @course.title.titleize
    if @course.save
      current_user.courses << @course
      flash[:success] = "Course created successfully"
      redirect_to courses_path
    else
      flash[:alert] = "Course create failed. Make sure the passwords match and that all inputs are filled in and are unique"
      render 'courses/new'
    end
  end

  def remove_course
    course = Course.find_by(title: params["course_title"])
    CoursesHelpers.remove_lectures(current_user, course)
    current_user.courses.delete(course)
    current_user.save
    render json: {stringifyTitle: course.title.parameterize, title: course.title}
  end

  private

  def set_current_user
    @current_user = current_user
  end

  def course_params
    params.require(:course).permit(:title, :description, :password, :password_confirmation)
  end
end
