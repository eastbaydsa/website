ActiveAdmin.register Page do
  index do
    column :title
    column :content do |post|
      truncate(strip_tags(post.content), length: 300)
    end
    column :show_in_menu
    actions
  end

  form do |f|
    f.inputs do
      f.input :title, as: :string
      f.input :content, as: :trix_editor
      f.input :slug, placeholder: 'Will be automatically generated if blank'
      f.input :parent
    end
    f.actions
  end

  permit_params :title, :content, :slug, :parent
end
