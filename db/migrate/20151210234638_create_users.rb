class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, null: false, blank: false
      t.string :email, null: false, blank: false
      t.string :encrypted_password, null: false, blank: false
      t.string :password_salt

      t.timestamps null: false
    end

    add_index :users, :email, unique: true

  end
end
