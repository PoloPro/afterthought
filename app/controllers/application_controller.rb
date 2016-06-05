class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user
  before_action :require_login

  def current_user
    if session[:student_id]
      @current_user ||= Student.find_by(id: session[:student_id])
    elsif session[:instructor_id]
      @current_user ||= Instructor.find_by(id: session[:instructor_id])
    end
  end

  def require_login
    unless current_user
      flash[:alert] = "You must be logged in to access that page"
      redirect_to login_path
    end
  end

  def check_if_logged_in
    if session[:student_id]
      flash[:notice] = "You are already logged in"
      redirect_to students_home_path
    elsif session[:instructor_id]
      flash[:notice] = "You are already logged in"
      redirect_to instructor_home_path
    end
  end

end
