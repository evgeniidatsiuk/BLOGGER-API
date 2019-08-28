class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.string :text
      t.boolean :read
      t.string :object_type
      t.integer :object_id
      t.integer :user_id

      t.timestamps
    end
  end
end
