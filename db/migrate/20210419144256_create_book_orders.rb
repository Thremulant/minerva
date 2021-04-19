class CreateBookOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :book_orders do |t|
      t.references :book, null: false, foreign_key: true
      t.references :order, null: false, foreign_key: true
      t.decimal :price, precision: 5, scale: 2
      t.integer :quantity

      t.timestamps
    end
  end
end
