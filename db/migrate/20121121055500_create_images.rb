class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.references :yardsale
      t.string     :image
      t.string     :remote_image_url
      t.string     :note

      t.timestamps
    end
    add_index :images, :yardsale_id
  end
end
