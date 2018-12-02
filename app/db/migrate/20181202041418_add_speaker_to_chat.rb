class AddSpeakerToChat < ActiveRecord::Migration[5.1]
  def change
    add_reference :chats, :speaker, foreign_key: {to_table: :users}
  end
end
