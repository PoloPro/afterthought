class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.references :student, foreign_key: true
      t.references :lecture, foreign_key: true
      t.text :content
      t.boolean :locked
    end
  end
end
