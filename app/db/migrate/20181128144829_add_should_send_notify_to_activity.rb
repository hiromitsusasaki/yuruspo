class AddShouldSendNotifyToActivity < ActiveRecord::Migration[5.1]
  def change
    add_column :activities, :should_send_notify, :boolean
  end
end
