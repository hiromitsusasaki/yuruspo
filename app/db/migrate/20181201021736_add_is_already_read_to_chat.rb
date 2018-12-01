class AddIsAlreadyReadToChat < ActiveRecord::Migration[5.1]
  def change
    add_column :chats, :is_already_read, :boolean, :default => false
  end
end
