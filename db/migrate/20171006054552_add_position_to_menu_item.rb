class AddPositionToMenuItem < ActiveRecord::Migration[5.1]
  def change
    rename_column :menu_items, :order, :position
  end
end
