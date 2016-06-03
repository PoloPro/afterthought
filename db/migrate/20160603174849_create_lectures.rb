class CreateLectures < ActiveRecord::Migration[5.0]
  def change
    create_table :lectures do |t|
      t.string :title
      t.text :description
      t.references :instructor, foreign_key: true
      t.references :course, foreign_key: true
      t.boolean :locked
      t.datetime :finish_time
    end
  end
end
