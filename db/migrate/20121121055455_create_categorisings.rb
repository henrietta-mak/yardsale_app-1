class CreateCategorisings < ActiveRecord::Migration
  def change
    create_table :categorisings do |t|
      t.references :yardsale
      t.references :category

      t.timestamps
    end
    add_index :categorisings, :yardsale_id
    add_index :categorisings, :category_id
    add_index :categorisings, [:yardsale_id, :category_id], :unique => true
  end
end
