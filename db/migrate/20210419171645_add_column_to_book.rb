class AddColumnToBook < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :new, :boolean
  end
end
