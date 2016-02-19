class StoreController < ApplicationController
include CreateCart
before_action :cart_assign
  def index
    @product = Product.order(:title)
    @add_product = Product.new
  end
end
