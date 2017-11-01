ActiveAdmin.register BlogPost do
  controller do
    defaults :finder => :find_by_slug
  end

  index do
    column :title
    column :content do |post|
      truncate(strip_tags(post.content), length: 300)
    end
    column :posted_at
    column :author
    column :direct_link do |post|
      @url = url_for(post)
      link_to(@url, @url, target: '_blank')
    end
    actions
  end

  show do
    attributes_table do
      row :title
      row :content do |post|
        post.content.html_safe
      end
      row :direct_link do |post|
        @url = url_for(post)
        link_to(@url, @url, target: '_blank')
      end
      columns_to_exclude = ["title", "content"]
      (BlogPost.column_names - columns_to_exclude).each do |c|
        row c.to_sym
      end
    end
    active_admin_comments
  end

  form do |f|
    f.object.posted_at = DateTime.now
    f.inputs do
      f.input :title, as: :string
      f.input :content, as: :trix_editor
      f.input :slug, placeholder: 'Will be automatically generated if blank'
      f.input :author
      f.input :posted_at
    end
    f.actions
  end

  permit_params :title, :content, :slug, :author_id, :posted_at
end
