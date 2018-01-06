ActiveAdmin.register Page do
  controller do
    defaults :finder => :find_by_slug
  end

  index do
    column :title
    column :content do |post|
      truncate(strip_tags(post.content), length: 300)
    end
    column :show_in_menu
    column :direct_link do |page|
      @url = url_for(page)
      link_to(@url, @url, target: '_blank')
    end
    actions
  end

  show do
    attributes_table do
      row :title
      row :subtitle
      row :content do |page|
        page.content.html_safe
      end
      row :direct_link do |page|
        @url = url_for(page)
        link_to(@url, @url, target: '_blank')
      end
      columns_to_exclude = ["title", "content"]
      (Page.column_names - columns_to_exclude).each do |c|
        row c.to_sym
      end
    end
    active_admin_comments
  end

  form do |f|
    f.inputs do
      f.input :title, as: :string
      f.input :content, as: :trix_editor
      f.input :slug, placeholder: 'Will be automatically generated if blank'
      f.input :parent
      f.input :subtitle, as: :string, description: "Used when displaying a link to a subpage"
    end
    f.actions
  end

  permit_params :title, :subtitle, :content, :slug, :parent_id
end
