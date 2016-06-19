class Review < ApplicationRecord
  belongs_to :lecture
  belongs_to :student
end
