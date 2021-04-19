class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.decimal :subtotal, precision: 5, scale: 2
      t.decimal :total, precision: 5, scale: 2
      t.decimal :pst, precision: 5, scale: 2
      t.decimal :gst, precision: 5, scale: 2
      t.decimal :hst, precision: 5, scale: 2
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
