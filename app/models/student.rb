class Student < ApplicationRecord
  has_many :enrollments
  has_many :courses, through: :enrollments
  has_many :reviews
  has_many :lectures, through: :reviews

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true, uniqueness: true, length: { maximum: 25 }
  
  has_secure_password

  def get_review(lecture_id)
    lecture = Lecture.find(lecture_id)
    reviews.each { |review| return review.content if review.lecture == lecture }
    return nil
  end

  def get_review_id(lecture_id)
    lecture = Lecture.find(lecture_id)
    reviews.each { |review| return review.id if review.lecture == lecture }
    return nil
  end

  def has_review?(lecture_id)
    lecture = Lecture.find(lecture_id)
    reviews.any?{ |review| review.lecture == lecture }
  end
end
