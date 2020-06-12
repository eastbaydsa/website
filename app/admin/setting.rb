# frozen_string_literal: true

ActiveAdmin.register_page 'Site Configuration' do
  menu parent: "Settings"

  title = 'Site Configuration'
  display = {
    homepage_header_text: :text,
    homepage_image_url: :s3_url,
    search_in_footer: :boolean,

    banner_a_show: :boolean,
    banner_b_title: :string,
    banner_c_text: :string,
    banner_d_learn_more: :string,
  }
  active_admin_settings_page(title: title, display: display)
end
