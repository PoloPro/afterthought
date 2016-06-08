class Enrollment < ApplicationRecord
  belongs_to :student, optional: true
  belongs_to :course

end
