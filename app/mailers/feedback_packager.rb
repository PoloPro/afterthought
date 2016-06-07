class FeedbackPackager

  def self.email_feedback(lecture, current_user)
    FeedbackMailer.lecture_feedback(lecture, current_user).deliver_now
  end

end