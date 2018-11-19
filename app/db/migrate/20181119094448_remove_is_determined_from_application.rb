class RemoveIsDeterminedFromApplication < ActiveRecord::Migration[5.1]
  def change
    remove_column :applications, :is_determined, :boolean
  end
end
