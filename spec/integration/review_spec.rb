require 'rails_helper'

context 'as a student', type: :integration do

  before (:all) do
    @instructor = Instructor.create(name: "Chris McCord", email: "chrismccord@gmail.com", password: "password")
    @course = Course.create(title: "Elixir", description: "Learn Elixir with Phoenix", password: "password")
    @student = Student.create(name: "Louis Clarke", email: "pocahontas@gmail.com", password: "password")

    @course.instructors << @instructor
    @course.students << @student

    @lecture = Lecture.create(title: "Match statements in Elixir", description: "one of the great features of Elixir", instructor: @instructor, course: @course, locked: false, finish_time: (Time.now - 1.hours))
  end

  it 'can visit a lecture page' do
    login_student(@student)

    visit '/courses/1/lectures/1'
    expect { page.to have_content("Match statements in Elixir") }
  end

end

context 'as an instructor', type: :integration do

  let (:instructor) { Instrutor.create(name: "Lord Mormont", email: "lordcommander@thewall.com", password: "stoneclaw") }

  it 'can visit a lecture page' do
  end

end


# Helper methods to login a student and an instructor
def login_student(student)
  visit '/login'
  fill_in 'student_email', with: student.email
  fill_in 'student_password', with: student.password
  click_on 'student-login-button'
end

def login_instructor(instructor)
  visit '/login'
  fill_in 'instructor_email', with: instructor.email
  fill_in 'instructor_password', with: instructor.password
  click_on 'instructor-login-button'
end