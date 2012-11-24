class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.references :user
      t.references :yardsale

      t.timestamps
    end
    add_index :relationships, :user_id
    add_index :relationships, :yardsale_id
    add_index :relationships, [:user_id, :yardsale_id], unique: true
  end
end
