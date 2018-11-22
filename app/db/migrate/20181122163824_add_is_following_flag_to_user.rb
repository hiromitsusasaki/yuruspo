class AddIsFollowingFlagToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :is_following_bot_for_user, :boolean
    add_column :users, :is_following_bot_for_circle, :boolean
  end
end
