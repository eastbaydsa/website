class AddSubtitleToPages < ActiveRecord::Migration[5.1]
  def change
    add_column :pages, :subtitle, :text
  end
end
