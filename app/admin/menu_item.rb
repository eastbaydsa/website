ActiveAdmin.register MenuItem do
  menu parent: "Navigation"

  include ActiveAdmin::SortableTable # creates the controller action which handles the sorting
  config.sort_order = 'position_asc' # assumes you are using 'position' for your acts_as_list column

  index do
    panel 'How Menu Items work!' do
      'Menu items can either belong to the "header" or the "footer", according to their "container" column. This list is ordered (you can reorder it by dragging the items up or down with the little triple-bar), and technically we have the two lists intermingled. But please be polite and keep the "footer" items in order at the bottom, and the "header" items in order at the top. Just to be nice.'
    end
    handle_column
    column :position
    column :label
    column :slug
    column :container
    actions
  end

  form do |f|
    f.inputs do
      f.input :label, as: :string
      f.input :slug, as: :string, hint: 'Must begin with \'/\' for relative links, or \'http\' for outbound links'
      f.input :container, as: :select, collection: ['header', 'footer']
    end
    f.actions
  end

  permit_params :label, :slug, :container, :order
end
