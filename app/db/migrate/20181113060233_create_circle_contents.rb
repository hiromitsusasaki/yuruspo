class CreateCircleContents < ActiveRecord::Migration[5.1]
  def change
    create_table :circle_contents do |t|
      t.belongs_to :circle, foreign_key: true
      t.belongs_to :content, foreign_key: true

      t.timestamps
    end
  end
end
