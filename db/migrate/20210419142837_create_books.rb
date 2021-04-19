class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :title
      t.integer :pages
      t.decimal :price, precision: 5, scale: 2
      t.references :genre, null: false, foreign_key: true
      t.references :author, null: false, foreign_key: true
      t.text :description

      t.timestamps
    end
  end
end
