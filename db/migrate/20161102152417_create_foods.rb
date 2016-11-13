class CreateFoods < ActiveRecord::Migration
  def change
    create_table :foods do |t|
      t.references :user, index: true, foreign_key: true
      t.text :content

      t.timestamps null: false
    end
  end
end