ActiveAdmin.register Page do
  controller do
    defaults :finder => :find_by_slug
  end

  index do
    column :slug do |page|
      link_to(page.slug, page, target: '_blank')
    end
    column :title
    column :content do |post|
      truncate(strip_tags(post.content), length: 300)
    end
    column :listed
    actions
  end

  show title: :slug do
    attributes_table do
      row :slug do |page|
        link_to(page.slug, page, target: '_blank')
      end
      row :title
      row :subtitle
      row :content do |page|
        article class: 'content' do
          page.content.html_safe
        end
      end
      row :meta_title
      row :meta_desc
      row :background_image_url do |page|
        if page.background_image_url != nil
          image_tag(page.background_image_url, style: 'width:200px;height:auto;')
        end
      end
      columns_to_exclude = ["title", "subtitle", "content", "background_image_url"]
      (Page.column_names - columns_to_exclude).each do |c|
        row c.to_sym
      end
    end
    active_admin_comments
  end

  form do |f|
    f.inputs do
      f.input :title, as: :string
      f.input :subtitle, as: :string
      f.input :content, as: :quill_editor
      f.input :slug, hint: 'This is the FULL path of the page after our root domain, and it has nothing to do with parent/child pages. E.g. if you want a page to live at "eastbaydsa.org/about/mission", put "about/mission" here. At least one Page should have the slug "home".'
      f.input :parent, collection: Page.pluck(:slug, :id)
      f.input :listed, hint: 'Unlisted pages can still be visited by URL, but will not show up as a sub-page'
      f.input :background_image_url, as: :s3_url
      f.input :meta_title, as: :string
      f.input :meta_desc, as: :string
    end
    f.inputs 'Sign Up' do
      f.input :show_form, label: 'Display a sign-up form directly after the Content of this page.', hint: 'Make sure to put some text at the end of the "Content" section above, like "Sign up for our newsletter" in bold, to explain what this form signs you up for!'
      f.input :form_tags, hint: 'Comma-separated list of NationBuilder tags to add when someone signs up (e.g. "eb_supporter" to sign them up for our newsletter). At least 1 is required.'
    end
    f.actions
  end

  permit_params :title, :subtitle, :content, :slug, :parent_id, :listed, :show_form, :form_tags,
    :background_image_url, :meta_title, :meta_desc
end
