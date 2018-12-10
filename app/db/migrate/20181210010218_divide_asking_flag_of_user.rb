class DivideAskingFlagOfUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :flag_about_to_ask_circle_bot, :boolean
    rename_column :users, :flag_is_about_to_asking, :flag_about_to_ask_user_bot
  end
end
