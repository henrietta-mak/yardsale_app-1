class CreateYardsales < ActiveRecord::Migration
  def change
    create_table :yardsales do |t|
      t.references :user
      t.string     :title
      t.date       :date
      t.time       :begin_time
      t.time       :end_time
      t.text       :description

      t.timestamps
    end
    add_index :yardsales, [:user_id, :created_at]
  end
end
