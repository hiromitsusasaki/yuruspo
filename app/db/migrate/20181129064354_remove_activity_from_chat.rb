class RemoveActivityFromChat < ActiveRecord::Migration[5.1]
  def change
    remove_reference :chats, :activity, foreign_key: true
  end
end
