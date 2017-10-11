ActiveAdmin.register Page do
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
