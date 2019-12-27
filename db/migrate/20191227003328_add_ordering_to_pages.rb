class AddOrderingToPages < ActiveRecord::Migration[5.1]
  def change
    add_column :pages, :order_id, :integer
    add_index :pages, :order_id, unique: true
  end
end
