class InstructorRegistrationsController < ApplicationController
  def new
    @instructor = Instructor.new
  end

  def create
    instructor_new = Instructor.new(instructor_params).name.titleize
    if instructor_new.save
      flash[:notice] = "Success! Welcome to Afterthought!"
      RegistrationMailer.registration_confirmation(instructor_new).deliver_now
      redirect_to instructor_path(instructor_new)
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
