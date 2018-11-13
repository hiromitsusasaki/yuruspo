class CreateCircles < ActiveRecord::Migration[5.1]
  def change
    create_table :circles do |t|
      t.string :name
      t.belongs_to :user, foreign_key: true
      t.text :introduction
      t.string :introduction_img_url
      t.text :default_auto_reply_comment

      t.timestamps
    end
  end
end
