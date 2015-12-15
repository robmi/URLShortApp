class CreateShorturls < ActiveRecord::Migration
  def change
    create_table :shorturls do |t|
      t.string :original_url
      t.string :surl
      t.integer :visits_count, default: 0
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
     add_index :shorturls, [:user_id, :original_url], unique: true
  end
end
