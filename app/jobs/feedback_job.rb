class FeedbackJob < ApplicationJob
  queue_as :default

  def perform(lecture, current_user)
    FeedbackMailer.lecture_feedback(lecture, current_user).deliver_now
    # mailer = FeedbackMailer.new
    # mailer.lecture_feedback(lecture, current_user).deliver_now
  end

end