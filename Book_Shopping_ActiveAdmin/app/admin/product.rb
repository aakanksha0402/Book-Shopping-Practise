ActiveAdmin.register Product do


  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :title,:description,:image_url,:price,:cart_id,:line_item_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end

#columns to be displayed
  index do
    column :title do |product|
      link_to product.title, admin_product_path(product)
    end
    column :description
    column :image_url do |img|
      image_tag img.image_url, size: '50x50'
    end
    column :price
    actions dropdown: true
  end

  show do
      attributes_table do
        row :title
        row :description
        row :image do |img|
          image_tag img.image_url, size: '200x300'
        end
        row :price
      end
      active_admin_comments
    end

#filters
  filter :title
  filter :description
  filter :price

#pagination
  config.per_page = 10
end
