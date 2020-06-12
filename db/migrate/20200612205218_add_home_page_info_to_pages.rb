class AddHomePageInfoToPages < ActiveRecord::Migration[5.1]
  def change
    add_column :pages, :homepage_campaign, :boolean
    add_column :pages, :homepage_text, :text
    add_column :pages, :homepage_color, :text

    remove_column :pages, :show_in_menu, :boolean
  end
end
