class ChangeStudentInEnrollments < ActiveRecord::Migration[5.0]
  def change
    remove_column :enrollments, :student_id
    add_column :enrollments, :student_id, :integer, index: true
  end
end
