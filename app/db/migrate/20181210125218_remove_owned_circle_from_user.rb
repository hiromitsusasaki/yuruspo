class RemoveOwnedCircleFromUser < ActiveRecord::Migration[5.1]
  def change
    remove_reference :users, :owned_circle, foreign_key: {to_table: :circles}
  end
end
