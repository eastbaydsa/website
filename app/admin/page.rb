ActiveAdmin.register Page do
  menu parent: "Content"

  controller do
    defaults :finder => :find_by_slug
  end

  filter :title_contains
  filter :slug_contains
  filter :content_or_subtitle_cont, label: "Content contains"
  filter :homepage_campaign

  index do
    column :slug do |page|
      link_to(page.slug, page, target: '_blank')
    end
    column :title
    column :subtitle
    column :content do |post|
      truncate(strip_tags(post.content), length: 50)
    end
    toggle_bool_column :homepage_campaign
    actions
  end

  show title: :slug do
    attributes_table title: 'Page Info' do
      row :title
      row :subtitle
      row :slug do |page|
        link_to(page.slug, page, target: '_blank')
      end
      row :parent do |page|
        if page.parent
          link_to(page.parent.title, admin_page_path(page.parent))
        end
      end
    end
    attributes_table title: 'Content' do
      row :background_image_url, label: 'Image' do |page|
        if page.background_image_url != nil
          image_tag(page.background_image_url, style: 'width:200px;height:auto;')
        end
      end 
      row :content do |page|
        article class: 'content' do
          page.content.html_safe
        end
      end
    end
    attributes_table title: 'Meta' do
      row :meta_title
      row :meta_desc
    end
    attributes_table title: 'Everything else' do
      columns_to_exclude = ["title", "subtitle", "content", 'slug', 'parent_id', "background_image_url", 'meta_title', 'meta_desc']
      (Page.column_names - columns_to_exclude).each do |c|
        row c.to_sym
      end
    end
  end

  form do |f|
    f.inputs 'Page info' do
      f.input :title, as: :string
      f.input :subtitle, as: :string
      f.input :slug, hint: 'This is the FULL path of the page after our root domain, and it has nothing to do with parent/child pages. E.g. if you want a page to live at "eastbaydsa.org/about/mission", put "about/mission" here. At least one Page should have the slug "home".'
      f.input :parent_id, as: :search_select, url: proc { admin_pages_path }, fields: [:title, :slug], display_name: 'title'
      f.input :listed, hint: 'Unlisted pages can still be visited by URL, but will not show up as a sub-page'
    end
    f.inputs 'Content' do
      f.input :background_image_url, as: :s3_url, label: 'Header image'
      f.input :content, as: :quill_editor
    end
    f.inputs 'Homepage feature' do
      f.input :homepage_campaign, as: :boolean, label: 'Feature as homepage campaign'
      f.input :homepage_text, as: :text, label: 'Homepage blurb'
      f.input :homepage_color, as: :color_picker, palette: [
        '#ed2c24', '#ea2127', '#3b2462', '#009aaf', '#e73c78', '#3059a9', '#6c0dcb', '#1d7832', '#ab6305'
      ]
      f.input :order, as: :select, collection: 1..10
    end
    f.inputs 'Meta information' do
      f.input :meta_title, as: :string
      f.input :meta_desc, as: :string
    end
    f.inputs 'Sign Up' do
      f.input :show_form, label: 'Display a sign-up form directly after the Content of this page.', hint: 'Make sure to put some text at the end of the "Content" section above, like "Sign up for our newsletter" in bold, to explain what this form signs you up for!'
      f.input :form_collect_phone, label: 'Collect phone number', hint: 'Useful for text/phone campaigns - requires both email and phone at signup.'
      f.input :form_tags, hint: 'Comma-separated list of NationBuilder tags to add when someone signs up (e.g. "eb_supporter" to sign them up for our newsletter). At least 1 is required.'
    end
    f.actions
  end

  permit_params :title, :subtitle, :content, :slug, :parent_id, :listed,
    :show_form, :form_collect_phone, :form_tags, :order,
    :background_image_url, :meta_title, :meta_desc, :homepage_campaign, 
    :homepage_text, :homepage_color
end
