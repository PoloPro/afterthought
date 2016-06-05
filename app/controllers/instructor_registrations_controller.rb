class InstructorRegistrationsController < ApplicationController
  skip_before_action :require_login
  def new
    @instructor = Instructor.new
  end

  def create
    instructor_new = Instructor.new(instructor_params)
    RegistrationHelpers.capitalize_name(instructor_new)
    if instructor_new.save
      RegistrationHelpers.email_success(instructor_new)
      flash[:notice] = "Success! Welcome to Afterthought!"
      redirect_to signup_path
    else
      flash.now[:alert] = "Signup Failed"
      render :new
    end
  end

  private

  def instructor_params
    params.require(:instructor).permit(:name, :password, :password_confirmation, :email)
  end
end
