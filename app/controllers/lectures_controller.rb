class LecturesController < ApplicationController

  def index
    # current_user ? @lectures = current_user.lectures : @lectures = []
    @lectures = Lecture.all
  end

end