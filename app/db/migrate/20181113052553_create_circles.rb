class CreateCircles < ActiveRecord::Migration[5.1]
  def change
    create_table :circles do |t|
      t.string :name
      t.belongs_to :owner, foreign_key: {to_table: :users}
      t.text :introduction
      t.string :introduction_picture_url
      t.text :default_auto_reply_comment

      t.timestamps
    end
  end
end
