class AddUniquenessConstraintToSlugs < ActiveRecord::Migration[5.1]
  def change
    add_index :pages, :slug, unique: true
    add_index :blog_posts, :slug, unique: true
  end
end
