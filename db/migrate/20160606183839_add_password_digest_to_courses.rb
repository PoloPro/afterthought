class AddPasswordDigestToCourses < ActiveRecord::Migration[5.0]
  def change
    add_column :courses, :password_digest, :string
  end
end
