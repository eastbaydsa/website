ActiveAdmin.register Admin do
  permit_params :email, :password, :password_confirmation

  index do
    selectable_column
    id_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

  controller do
    include ActiveAdmin::ViewsHelper
  end

  # Creates route /admin/admins/get_presigned_url.
  collection_action :get_presigned_url, method: :get do
    render plain: generate_presigned_url(params[:filename])
  end

end
