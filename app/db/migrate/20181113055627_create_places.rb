class CreatePlaces < ActiveRecord::Migration[5.1]
  def change
    create_table :places do |t|
      t.string :name
      t.string :tel
      t.string :address
      t.belongs_to :city, foreign_key: true

      t.timestamps
    end
  end
end
