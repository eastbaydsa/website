ActiveAdmin.register Page do
  form do |f|
    f.inputs do
      f.input :title, as: :string
      f.input :content
      f.input :slug
      f.input :parent
    end
    f.actions
  end

  permit_params :title, :content, :slug, :parent
end
