class Instructor < ApplicationRecord
  has_many :instructor_courses
  has_many :courses, through: :instructor_courses
  has_many :lectures
  has_many :reviews, through: :lectures

  has_secure_password
end
