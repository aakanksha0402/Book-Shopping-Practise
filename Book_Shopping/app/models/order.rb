class Order < ActiveRecord::Base
  has_many :line_items, dependent: :destroy
  PAY_MODE = [:cheque, :credit_card, :purchase_order]
  validates :name, :address, :email, presence: true
  validates :name, :length => {minimum: 0, maximum: 300}
  validates :pay_type, :inclusion => { :in => I18n.t(PAY_MODE, scope: 'order.PAY_MODE'), :message => "is not a valid" }

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end
end
