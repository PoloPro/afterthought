class InstructorRegistrationsController < ApplicationController
  def new
    @instructor = Instructor.new
  end

  def create
    instructor_new = Instructor.new(student_params)
    if instructor_new.save
      flash[:notice] = "Success! Welcome to Afterthought!"
      redirect_to instructor_path(instructor_new)
    else
      flash.now[:alert] = "Signup Failed"
      render :new
    end
  end

  private

  def instructor_params
    params.require(:instructor).permit(:name, :password, :password_confirmation, :email_address)
  end
end
