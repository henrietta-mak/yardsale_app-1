class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.references :user
      t.references :yardsale
      t.string     :street
      t.string     :city
      t.string     :state
      t.integer    :zip_code
      t.float      :latitude
      t.float      :longitude
      
      t.timestamps
    end
    add_index :addresses, :user_id
    add_index :addresses, :yardsale_id
  end
end
