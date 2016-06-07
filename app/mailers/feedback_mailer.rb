class FeedbackMailer < ApplicationMailer

  def self.email_feedback(lecture, current_user)
    # Deliver feedback via email now
    # FeedbackMailer.lecture_feedback(lecture, current_user).deliver_now

    lecture_timer = LectureTimer.new(lecture)
    lecture_feedback(lecture, current_user).deliver_later(wait_until: lecture_timer.lock_time )
    puts "Success."    
  end

  def lecture_feedback(lecture, current_user)
    @current_user = current_user
    @lecture = lecture
    @reviews = lecture.get_reviews
    @lecture_url = course_lecture_url(@lecture.course.id, @lecture.id)

    mail(to: "sampletest@sample.com", subject: "Feedback")
  end

end