class Lecture < ApplicationRecord
  has_many :students
  has_many :reviews
  belongs_to :instructor
end