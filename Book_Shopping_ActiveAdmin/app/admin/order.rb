ActiveAdmin.register Order do


  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end

  index do
    column :id do |order|
      link_to order.id, admin_order_path(order)
    end
    column :name
    column :address
    column :email
    column :pay_type
  end

  #filters
  filter :name
  filter :address
  filter :email
  filter :pay_type, as: :check_boxes, collection: Order::PAY_MODE

  #pagination
  config.per_page = 10
end
