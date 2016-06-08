class EnrollmentMailer < ApplicationMailer
  def enrollment_confirmation(student, course, enrollment, current_user)
    @current_user = current_user
    @course = course
    @student = student
    @enrollment = enrollment

    attachments.inline['afterthought_logo.png'] = File.read('app/assets/images/afterthought_logo_darkpurple_medium.png')
    
    mail(:to => "#{student.name} <#{student.email}>", :subject => "Course Invitation")
  end
end
