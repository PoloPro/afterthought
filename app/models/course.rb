class Course < ApplicationRecord
  has_many :instructor_courses
  has_many :instructors, through: :instructor_courses
  has_many :enrollments
  has_many :students, through: :enrollments
  has_many :lectures

  validates :title, uniqueness: true, presence: true
  validates :description, uniqueness: true, presence: true

  has_secure_password
end
