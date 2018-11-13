class CreateChats < ActiveRecord::Migration[5.1]
  def change
    create_table :chats do |t|
      t.belongs_to :activity, foreign_key: true
      t.belongs_to :application, foreign_key: true
      t.integer :speaker, default: 0, null: false, limit: 1
      t.text :body

      t.timestamps
    end
  end
end
