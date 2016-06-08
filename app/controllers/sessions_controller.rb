class SessionsController < ApplicationController

  skip_before_action :require_login
  before_action :check_if_logged_in, only: [:new]

  def new
    @student = Student.new
    @instructor = Instructor.new
  end

  def create
    if SessionHelpers.student_user?(params)
      student = Student.find_by(email: params[:student][:email])
      if student && student.authenticate(params[:student][:password])
        session[:student_id] = student.id
        redirect_to courses_path
      else
        login_fail
      end
    else
      instructor = Instructor.find_by(email: params[:instructor][:email])
      if instructor && instructor.authenticate(params[:instructor][:password])
        session[:instructor_id] = instructor.id
        redirect_to courses_path
      else
        login_fail
      end
    end
  end

  def destroy
    session[:student_id] = nil
    session[:instructor_id] = nil
    redirect_to login_path
  end

  private
  def login_fail
    flash[:alert] = "Login Failed."
    redirect_to login_path
  end

end
