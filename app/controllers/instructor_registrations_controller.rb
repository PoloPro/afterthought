class InstructorRegistrationsController < ApplicationController
  def new
    @instructor = Instructor.new
  end

  def create
  end
end
