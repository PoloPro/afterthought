class StudentsHelpers

  def self.find_the_student(search_term)
    student = Student.find_by(name: search_term)
    student = Student.find_by(email: search_term) if student.nil?
    student
  end
end
