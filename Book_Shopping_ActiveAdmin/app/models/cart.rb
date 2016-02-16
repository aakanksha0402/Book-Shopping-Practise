class Cart < ActiveRecord::Base
  has_many :line_items, dependent: :destroy
  has_many :products, through: :line_items
  # before_create :does_product_exists

  def does_product_exists(product_id)
    prod_exists = line_items.find_by(product_id: product_id)
    if prod_exists
      prod_exists.quantity += 1
    else
      prod_exists = line_items.build(product_id: product_id)
    end
    prod_exists
  end

  def total_price
    sum=0
    line_items.each do |item|
      sum += item.total_price
    end
    sum
  end

end
