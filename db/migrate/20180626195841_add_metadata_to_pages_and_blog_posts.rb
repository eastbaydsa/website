class AddMetadataToPagesAndBlogPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :blog_posts, :meta_title, :string
    add_column :blog_posts, :meta_desc, :string
    add_column :pages, :meta_title, :string
    add_column :pages, :meta_desc, :string
  end
end
