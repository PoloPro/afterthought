class StudentRegistrationsController < ApplicationController
  skip_before_action :require_login

  def new
    if current_user.class == Instructor || current_user.class == Student
      flash[:notice] = "You must be signed out to register as a new user"
      redirect_to courses_path
    end
    @student = Student.new
  end

  def create
    @student = Student.new(student_params)
    RegistrationHelpers.capitalize_name(@student)
    if @student.save
      RegistrationHelpers.email_success(@student)
      flash[:notice] = "Success! Welcome to Afterthought!"
      redirect_to login_path
    else
      flash.now[:alert] = "Signup Failed"
      render :new
    end
  end

  private
  def student_params
  params.require(:student).permit(:name, :password, :password_confirmation, :email)
  end
end
