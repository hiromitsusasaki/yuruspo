class CreateSearchQueries < ActiveRecord::Migration[5.1]
  def change
    create_table :search_queries do |t|
      t.references :user, foreign_key: true
      t.references :content, foreign_key: true
      t.references :city, foreign_key: true
      t.date :date
      t.integer :sent_activity_count

      t.timestamps
    end
  end
end
