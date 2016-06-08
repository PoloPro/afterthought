class AddStudentPlaceholderToEnrollments < ActiveRecord::Migration[5.0]
  def change
    add_column :enrollments, :student_placeholder, :integer
  end
end
