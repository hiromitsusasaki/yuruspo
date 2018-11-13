class CreateActivities < ActiveRecord::Migration[5.1]
  def change
    create_table :activities do |t|
      t.belongs_to :circle, foreign_key: true
      t.belongs_to :place_content, foreign_key: true
      t.integer :max_member_number
      t.text :auto_reply_comment
      t.date :date
      t.time :start_time
      t.time :end_time

      t.timestamps
    end
  end
end
