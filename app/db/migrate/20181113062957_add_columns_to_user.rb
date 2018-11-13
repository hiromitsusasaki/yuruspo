class AddColumnsToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :uid, :string
    add_column :users, :provider, :string
    add_column :users, :display_name, :string
    add_column :users, :status_message, :text
    add_column :users, :picture_url, :string
    add_column :users, :is_circle_admin, :boolean

  end
end
