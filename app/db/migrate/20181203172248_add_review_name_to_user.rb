class AddReviewNameToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :review_name, :string
  end
end
