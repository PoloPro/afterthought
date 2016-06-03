class Course < ApplicationRecord
  has_many :instructors
  has_many :enrollments
  has_many :students, through: :enrollments
  has_many :lectures
end