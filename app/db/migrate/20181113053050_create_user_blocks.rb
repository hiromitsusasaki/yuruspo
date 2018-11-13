class CreateUserBlocks < ActiveRecord::Migration[5.1]
  def change
    create_table :user_blocks do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :circle, foreign_key: true

      t.timestamps
    end
  end
end
