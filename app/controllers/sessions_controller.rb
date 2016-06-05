class SessionsController < ApplicationController
  def new
    @student = Student.new
    @instructor = Instructor.new
  end

  def create
  end

  def destroy
  end
end
