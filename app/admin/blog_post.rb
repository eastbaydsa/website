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
    column :listed
    column :direct_link do |post|
      @url = blog_post_path(
        year: post.posted_at.year,
        month: post.posted_at.month,
        day: post.posted_at.day,
        slug: post.slug
      )
      link_to(@url, @url, target: '_blank')
    end
    actions
  end

  show do
    attributes_table do
      row :title
      row :content do |post|
        article class: 'content' do
          post.content.html_safe
        end
      end
      row :direct_link do |post|
        @url = blog_post_path(
          year: post.posted_at.year,
          month: post.posted_at.month,
          day: post.posted_at.day,
          slug: post.slug
        )
        link_to(@url, @url, target: '_blank')
      end
      row :meta_title
      row :meta_desc
      row :featured_image do |post|
        if post.featured_image != nil
          image_tag(post.featured_image, style: 'width:200px;height:auto;')
        end
      end
      columns_to_exclude = ["title", "content"]
      (BlogPost.column_names - columns_to_exclude).each do |c|
        row c.to_sym
      end
    end
    active_admin_comments
  end

  form do |f|
    f.object.posted_at ||= DateTime.now
    f.inputs do
      f.input :title, as: :string
      f.input :content, as: :quill_editor
      f.input :featured_image, as: :s3_url
      f.input :slug, hint: 'Blog posts live at "/blog/:slug". Will be automatically generated if blank'
      f.input :author
      f.input :posted_at
      f.input :listed, hint: 'Unlisted posts can still be visited by URL, but will not show up in the main list of posts'
      f.input :meta_title, as: :string
      f.input :meta_desc, as: :string
    end
    f.actions
  end

  permit_params :title, :content, :slug, :author_id, :posted_at, :featured_image, :listed, :meta_title, :meta_desc
end
