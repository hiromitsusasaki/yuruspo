class RemoveSpeakerFromChat < ActiveRecord::Migration[5.1]
  def change
    remove_column :chats, :speaker, :integer
  end
end
