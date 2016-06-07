class StudentsController < ApplicationController

  def home
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
end


private

def autocomplete_data(data, label_type, category_type)
  title_hash = {}
  title_hash["label"] = label_type
  title_hash["category"] = category_type
  data << title_hash
end
