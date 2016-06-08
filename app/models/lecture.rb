class Lecture < ApplicationRecord
  has_many :reviews
  belongs_to :instructor
  belongs_to :course

  validates :title, presence: true
  validates :description, presence: true
  validates :finish_time, presence: true

  def get_reviews
    grouped_reviews = {}

    reviews.each do |review|
      if review.anonymous
        grouped_reviews[review.content] = "anonymous"
      else
        grouped_reviews[review.content] = review.student.name
      end
    end

    grouped_reviews
  end

  def format_end_time
    end_time = created_at > finish_time ? created_at : finish_time
    end_time.strftime("%A, %l:%M %p")
  end

end
