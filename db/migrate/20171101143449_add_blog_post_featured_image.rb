class AddBlogPostFeaturedImage < ActiveRecord::Migration[5.1]
  def change
    add_column :blog_posts, :featured_image, :string
  end
end
