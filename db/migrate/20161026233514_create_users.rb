class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest

      t.timestamps null: false
      #ユニークインデックスを追加し、
      #メールアドレスが他と異なるようにする
      t.index :email, unique: true
    end
  end
end
