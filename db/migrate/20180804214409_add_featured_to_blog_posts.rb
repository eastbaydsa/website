class AddFeaturedToBlogPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :blog_posts, :featured, :boolean, default: true, null: false
  end
end
