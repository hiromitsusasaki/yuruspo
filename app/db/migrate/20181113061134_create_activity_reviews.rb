class CreateActivityReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :activity_reviews do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :activity, foreign_key: true
      t.integer :evaluation
      t.text :comment

      t.timestamps
    end
  end
end
