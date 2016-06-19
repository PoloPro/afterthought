class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :instructor_access_only
  before_action :require_login

  def current_user
    if session[:student_id]
      @current_user ||= Student.find_by(id: session[:student_id])
    elsif session[:instructor_id]
      @current_user ||= Instructor.find_by(id: session[:instructor_id])
    end

    @current_user ? @current_user : OpenStruct.new(name: "Guest", email: "guest@placeholder.com")
  end

  def require_login
    if current_user.class == OpenStruct
      flash[:info] = "Please sign in to continue"
      redirect_to login_path
    end
  end

  def check_if_logged_in
    if session[:student_id] || session[:instructor_id]
      flash[:alert] = "You are already signed in"
      redirect_to courses_path
    end
  end

  def instructor_access_only
    unless current_user.class == Instructor
      flash[:alert] = "You do not have permissions to view that page"
      redirect_to root_path
    end
  end

end
