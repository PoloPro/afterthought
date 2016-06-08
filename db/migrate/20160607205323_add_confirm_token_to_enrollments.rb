class AddConfirmTokenToEnrollments < ActiveRecord::Migration[5.0]
  def change
    add_column :enrollments, :confirm_token, :string
  end
end
