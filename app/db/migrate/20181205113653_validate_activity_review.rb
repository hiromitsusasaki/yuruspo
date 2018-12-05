class ValidateActivityReview < ActiveRecord::Migration[5.1]
  def change
    add_index  :activity_reviews, [:activity_id, :user_id], unique: true
  end
end
