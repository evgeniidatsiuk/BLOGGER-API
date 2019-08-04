class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :object_id
      t.string  :object_type
      t.string  :text

      t.timestamps
    end
  end
end
