class Lecture < ApplicationRecord
  has_many :reviews
  belongs_to :instructor
  belongs_to :course
end
