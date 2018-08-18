class AddPhoneToPageForm < ActiveRecord::Migration[5.1]
  def change
    add_column :pages, :form_collect_phone, :boolean, default: false, null: false
  end
end
