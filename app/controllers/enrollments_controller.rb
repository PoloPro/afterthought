class EnrollmentsController < ApplicationController
  skip_before_action :require_login, only: [:confirm_email]

  def create

    course = Course.find(params[:course_id])
    student = StudentsHelpers.find_the_student(params[:student_term])
    @enrollment = Enrollment.new(course: course, student_placeholder: student.id)
    @enrollment.confirm_token = SecureRandom.urlsafe_base64.to_s
    if !already_enrolled?(student, course) && @enrollment.save
      EnrollmentMailer.enrollment_confirmation(student, course, @enrollment, current_user).deliver_now
      flash = "Your email invitation to #{student.name} has been sent."
      success = true
      render json: {data: flash, success: success}
    else
      flash = "Either something went wrong or the student is already enrolled."
      success = false
      render json: {data: flash, success: success}
    end
  end

  def confirm_email
    enrollment = Enrollment.find_by_confirm_token(params[:confirmation_token])
    unless enrollment == nil
      enrollment.confirm_token = nil
      @student = Student.find(enrollment.student_placeholder)
      enrollment.student = @student
      enrollment.save
      flash[:success] = "Enrollment successful."
      redirect_to courses_path
    else
      flash[:danger] = "Enrollment not successful. Please get course instructor to resend the invitation, then click the link on the invitation to enroll."
      redirect_to courses_path
    end
  end

  private

  def already_enrolled?(student, course)
    student.courses.include?(course)
  end
end
