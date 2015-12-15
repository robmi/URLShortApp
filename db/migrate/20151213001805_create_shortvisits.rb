class CreateShortvisits < ActiveRecord::Migration
  def change
    create_table :shortvisits do |t|
      t.string :ip
      t.string :city
      t.string :state
      t.string :country
      t.references :shorturl, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
