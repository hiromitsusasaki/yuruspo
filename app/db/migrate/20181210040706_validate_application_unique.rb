class ValidateApplicationUnique < ActiveRecord::Migration[5.1]
  def change
    add_index  :applications, [:activity_id, :user_id], unique: true
  end
end
