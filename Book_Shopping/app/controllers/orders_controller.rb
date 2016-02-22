class OrdersController < ApplicationController
include CreateCart
before_action :cart_assign, only: [:index,:new, :create, :show, :edit]
before_action :set_order, only: [:show, :edit, :update, :destroy]

  def index
    @orders = Order.all
  end

  def show
  end

  def new
    if @cart.line_items.empty?
      redirect_to store_index_path
      return
    end
  @order = Order.new
  end

  def edit
  end

  def create
    @order = Order.new(order_params)
    @order.add_line_items_from_cart(@cart)
      if @order.save
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil
        if @order.pay_type == 'Credit Card'
          session[:email] = @order.email
          redirect_to new_payment_path
        else
          OrderNotifier.received(@order).deliver
          respond_to do |format|
            format.html { redirect_to store_index_path, notice: t('order.sent_email') }
            format.json { render action: 'show', status: :created, location: @order }
          end
        end
      else
        format.html { render action: 'new' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
  end

  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url }
      format.json { head :no_content }
    end
  end

  private
    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      # I18n.locale = 'en'
      params.require(:order).permit(:name, :address, :email, :pay_type)
    end
end
