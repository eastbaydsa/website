class CreateMenuItems < ActiveRecord::Migration[5.1]
  def change
    create_table :menu_items do |t|
      t.string :label
      t.string :slug
      t.integer :order

      t.timestamps
    end
  end
end
