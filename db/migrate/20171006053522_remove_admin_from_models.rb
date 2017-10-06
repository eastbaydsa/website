class RemoveAdminFromModels < ActiveRecord::Migration[5.1]
  def change
    remove_column :pages, :admin_id
    rename_column :blog_posts, :admin_id, :author_id
  end
end
