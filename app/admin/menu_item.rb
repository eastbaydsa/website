ActiveAdmin.register MenuItem do
  include ActiveAdmin::SortableTable # creates the controller action which handles the sorting
  config.sort_order = 'position_asc' # assumes you are using 'position' for your acts_as_list column

  index do
    handle_column
    column :label
    column :slug
  end

  permit_params :label, :slug, :order
end
