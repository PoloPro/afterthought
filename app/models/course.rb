class Course < ApplicationRecord
  has_many :instructor_courses
  has_many :instructors, through: :instructor_courses
  has_many :enrollments
  has_many :students, through: :enrollments
  has_many :lectures

  validates :title, uniqueness: true, presence: true, length: { minimum: 5, maximum: 50 }
  validates :description, uniqueness: true, presence: true, length: { minimum: 10, maximum: 150 }

  has_secure_password
end
