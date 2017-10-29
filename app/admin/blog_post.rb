ActiveAdmin.register BlogPost do
  index do
    column :title
    column :content do |post|
      truncate(strip_tags(post.content), length: 300)
    end
    column :posted_at
    column :author
    actions
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
