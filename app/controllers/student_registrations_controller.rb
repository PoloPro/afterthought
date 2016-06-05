class StudentRegistrationsController < ApplicationController
  def new
    @student = Student.new
  end

  def create
    student_new = Student.new(student_params).name.titleize
    if student_new.save
      flash[:notice] = "Success! Welcome to Afterthought!"
      RegistrationMailer.registration_confirmation(student_new).deliver_now
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
