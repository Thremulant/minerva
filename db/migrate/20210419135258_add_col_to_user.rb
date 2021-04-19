class AddColToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :name, :string
    add_column :users, :address, :string
    add_column :users, :postal_code, :string
    add_column :users, :province_id, :reference
  end
end
