module CreateCart extend ActiveSupport::Concern
private
def cart_assign
  @cart = Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    @cart  = Cart.create
    session[:cart_id] = @cart.id
end
end
