class CreateInquiries < ActiveRecord::Migration[5.1]
  def change
    create_table :inquiries do |t|
      t.references :user, foreign_key: true
      t.text :body
      t.boolean :is_responded

      t.timestamps
    end
  end
end
