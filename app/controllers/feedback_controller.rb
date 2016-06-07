class FeedbackController < ApplicationController

  def collate_and_send
    lecture = Lecture.find(params[:id])
    timer = LectureTimer.new(lecture)

    # FeedbackJob.set(wait_until: timer.lock_time)
    #            .perform_later(lecture, current_user)
    
    FeedbackJob.perform_now(lecture, current_user)

    flash[:notice] = "Feedback compiled and emailed to all instructors."
    redirect_to course_lecture_path(lecture.course.id, lecture.id)
  end

end