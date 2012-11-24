class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :user
      t.references :yardsale
      t.string     :comment

      t.timestamps
    end
    add_index :comments, :user_id
    add_index :comments, :yardsale_id
    add_index :comments, [:user_id, :yardsale_id]
  end
end
