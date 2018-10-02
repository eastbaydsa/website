# frozen_string_literal: true

ActiveAdmin.register_page 'Setting' do
  title = 'Settings'
  menu label: title
  display = {
    homepage_hardcoded: :boolean,
    homepage_image_url: :string
  }
  active_admin_settings_page(title: title, display: display)
end
