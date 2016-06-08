class EnrollmentMailer < ApplicationMailer
  def enrollment_confirmation(student, course, enrollment, current_user)
    @current_user = current_user
    @course = course
    @student = student
    @enrollment = enrollment
    mail(:to => "#{student.name} <#{student.email}>", :subject => "Course Invitation")
  end
end
