class AddHomepageFeaturedImage < ActiveRecord::Migration[5.1]
  def change
    add_column :homes, :featured_image, :string
  end
end
