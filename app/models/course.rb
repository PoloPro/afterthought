class Course < ApplicationRecord
  has_many :instructor_courses
  has_many :instructors, through: :instructor_courses
  has_many :enrollments
  has_many :students, through: :enrollments
  has_many :lectures
end
