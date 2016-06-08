class StudentsController < ApplicationController

  def edit
    @user = Student.new
  end

  def update
    if current_user.update(student_custom_params)
      flash[:success] = "Your information has been successfully updated"
      redirect_to courses_path
    else
      flash[:danger] = "Oh no! Edit failed."
      redirect_to edit_student_path(current_user)
    end
  end

  def student_autocomplete
    students = Student.all
    data = []
    students.each do |student|
      label_type = student.name
      autocomplete_data(data, label_type, "Name")
    end
    students.each do |student|
      label_type = student.email
      autocomplete_data(data, label_type, "Email")
    end
    render json: {data: data}
  end

  def remove_student
    student = Student.find_by(id: params["student_id"])
    course = Course.find_by(id: params["course_id"])
    course.students.delete(student)
    course.save
    render json: {stringifyName: student.name.parameterize, name: student.name, courseTitle: course.title}
  end


  private

  def autocomplete_data(data, label_type, category_type)
    title_hash = {}
    title_hash["label"] = label_type
    title_hash["category"] = category_type
    data << title_hash
  end

  def student_custom_params
    params.require(:student).permit(:name, :password, :password_confirmation, :email)
  end
end
