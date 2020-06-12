ActiveAdmin.register Redirect do
  menu parent: "Navigation"

  index do
    column :from_path
    column :to_url
    column :clicks
    actions
  end

  show do
    attributes_table do
      row :from_path
      row :to_url
      row :clicks
    end
  end

  form do |f|
    f.inputs do
      f.input :from_path, as: :string, hint: 'Must begin with "/". Once created, cannot be changed (just delete/recreate new ones)', input_html: { disabled: f.object.persisted? }
      f.input :to_url, as: :string, hint: 'Must begin with "/" for relative links, or "http" for outbound links'
    end
    f.actions
  end

  permit_params :from_path, :to_url
end

