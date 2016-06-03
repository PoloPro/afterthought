class Instructor < ApplicationRecord
  has_many :courses
  has_many :lectures
  has_many :reviews, through: :lectures
end