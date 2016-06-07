class FeedbackMailer < ApplicationMailer

  def lecture_feedback_email(lecture, instructors)
    @lecture = lecture
    @reviews = lecture.get_reviews
    mail(to: wesley.davis@flatironschool.com, subject: "Feedback")
  end

end