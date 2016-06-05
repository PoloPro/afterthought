class Student < ApplicationRecord
  has_many :courses
  has_many :reviews
end