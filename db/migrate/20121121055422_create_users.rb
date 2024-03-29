class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string   :first_name
      t.string   :last_name
      t.string   :username
      t.string   :email
      t.string   :password_digest
      t.string   :remember_token
      t.string   :password_reset_token
      t.datetime :password_reset_sent_at
      t.boolean  :admin, :default => false

      t.timestamps
    end
    add_index :users, :username, :unique => true
    add_index :users, :email,    :unique => true
    add_index :users, :remember_token
  end
end
