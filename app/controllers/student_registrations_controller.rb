class StudentRegistrationsController < ApplicationController
  skip_before_action :require_login
  
  def new
    @student = Student.new
  end

  def create
    student_new = Student.new(student_params)
    RegistrationHelpers.capitalize_name(student_new)
    if student_new.save
      RegistrationHelpers.email_success(student_new)
      flash[:notice] = "Success! Welcome to Afterthought!"
      redirect_to signup_path
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
