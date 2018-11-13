class CreateContents < ActiveRecord::Migration[5.1]
  def change
    create_table :contents do |t|
      t.string :name
      t.belongs_to :event_type, foreign_key: true

      t.timestamps
    end
  end
end
