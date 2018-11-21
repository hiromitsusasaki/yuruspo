class AddFlagIsAboutToAskingToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :flag_is_about_to_asking, :boolean
  end
end
