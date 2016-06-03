class CreateInstructorCourses < ActiveRecord::Migration[5.0]
  def change
    create_table :instructor_courses do |t|
      t.references :instructor, foreign_key: true
      t.references :course, foreign_key: true
    end
  end
end
