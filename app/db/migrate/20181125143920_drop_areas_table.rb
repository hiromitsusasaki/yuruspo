class DropAreasTable < ActiveRecord::Migration[5.1]
  def change
    remove_foreign_key :places, :areas
    remove_index :places, :area_id
    remove_reference :places, :area
    add_reference :places, :city, index: true
    add_foreign_key :places, :cities
    drop_table :user_areas
    drop_table :areas
  end
end
