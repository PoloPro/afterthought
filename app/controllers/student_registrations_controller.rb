class StudentRegistrationsController < ApplicationController
  def new
    @student = Student.new
  end

  def create
    student_new = Student.new(student_params)
    if student_new.save
      flash[:notice] = "Success! Welcome to Afterthought!"
      redirect_to student_path(student_new)
    else
      flash.now[:alert] = "Signup Failed"
      render :new
    end
  end

  private
  def student_params
  params.require(:student).permit(:name, :password, :password_confirmation, :email_address)
  end
end
