class CreateApplications < ActiveRecord::Migration[5.1]
  def change
    create_table :applications do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :activity, foreign_key: true
      t.integer :join_member_number
      t.boolean :is_determined

      t.timestamps
    end
  end
end
