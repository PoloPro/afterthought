class InstructorsController < ApplicationController

  def edit
    @user = Instructor.new
  end

  def update
    if current_user.update(instructor_custom_params)
      flash[:success] = "Your information has been successfully updated"
      redirect_to courses_path
    else
      flash[:danger] = "Oh no! Edit failed."
      redirect_to edit_instructor_path(current_user)
    end
  end

  def instructor_custom_params
    params.require(:instructor).permit(:name, :password, :password_confirmation, :email)
  end
end
