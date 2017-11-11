ActiveAdmin.register Home do
  index do
    column :intro do |home|
      strip_tags(home.intro)
    end
    column :featured_page_1
    column :featured_page_2
    column :featured_image do |home|
      image_tag(home.featured_image, style: 'width:200px;height:auto;')
    end
    actions
  end

  show do
    attributes_table do
      row :intro do |home|
        home.intro.html_safe
      end
      row :featured_image do |home|
        image_tag(home.featured_image, style: 'width:200px;height:auto;')
      end
      row :featured_page_1 do |home|
        link_to(home.featured_page_1.title, url_for(home.featured_page_1), target: '_blank')
      end
      row :featured_page_2 do |home|
        link_to(home.featured_page_2.title, url_for(home.featured_page_2), target: '_blank')
      end
      columns_to_exclude = ["id", "intro", "featured_image",
                            "featured_page_1_id", "featured_page_2_id"]
      (Home.column_names - columns_to_exclude).each do |c|
        row c.to_sym
      end
    end
    active_admin_comments
  end

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
