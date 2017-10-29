ActiveAdmin.register Home do
  form do |f|
    f.inputs do
      f.input :intro, as: :trix_editor
      f.input :featured_page_1
      f.input :featured_page_2
      f.input :featured_image, as: :s3_url
    end
    f.actions
  end

  permit_params :intro, :featured_page_1_id, :featured_page_2_id, :featured_image
end
