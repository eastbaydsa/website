class CreateHomes < ActiveRecord::Migration[5.1]
  def change
    create_table :homes do |t|
      t.text :intro
      t.integer :featured_page_1_id
      t.integer :featured_page_2_id

      t.timestamps
    end
  end
end
