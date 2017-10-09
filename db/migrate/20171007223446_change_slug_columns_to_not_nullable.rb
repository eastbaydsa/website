class ChangeSlugColumnsToNotNullable < ActiveRecord::Migration[5.1]
  def change
    change_column_null :pages, :slug, false
    change_column_null :blog_posts, :slug, false
  end
end
