class CreateStudentLectures < ActiveRecord::Migration[5.0]
  def change
    create_table :student_lectures do |t|
      t.references :student, foreign_key: true
      t.references :lecture, foreign_key: true
    end
  end
end
