class FeedbackMailer < ApplicationMailer

  def lecture_feedback(lecture, current_user)
    @current_user = current_user
    @lecture = lecture
    @reviews = lecture.get_reviews
    @lecture_url = course_lecture_url(@lecture.course.id, @lecture.id)
    
    attachments.inline['afterthought_logo.png'] = File.read('app/assets/images/afterthought_logo_darkpurple_medium.png')

    mail(
     to: @current_user.email, 
     subject: "Feedback for #{@lecture.title}"
     )

  end

end