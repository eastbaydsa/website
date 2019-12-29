class AddOrderingToPages < ActiveRecord::Migration[5.1]
  def change
    add_column :pages, :order, :integer
    add_index :pages, :order, unique: true
  end
end
