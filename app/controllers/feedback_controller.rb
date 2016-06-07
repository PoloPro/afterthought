class FeedbackController < ApplicationController

  def collate_and_send
    lecture = Lecture.find(params[:id])

    FeedbackMailer.email_feedback(lecture, current_user)
  end

end