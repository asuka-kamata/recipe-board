class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.references :user, index: true, foreign_key: true
      t.string :category
      t.string :foods_name
      t.integer :number
      t.datetime :limit

      t.timestamps null: false
    end
  end
end
