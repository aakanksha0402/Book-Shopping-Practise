class AdministratorsController < ApplicationController
  before_filter :authorize
  before_action :set_administrator, only: [:show, :edit, :update, :destroy]
  include CreateCart
  before_action :cart_assign

  def index
    @administrators = Administrator.all
  end

  def show
  end

  def new
    @administrator = Administrator.new
  end

  def edit
  end

  def create
    @administrator = Administrator.new(administrator_params)

    respond_to do |format|
      if @administrator.save
        format.html { redirect_to @administrator, notice: 'Administrator was successfully created.' }
        format.json { render action: 'show', status: :created, location: @administrator }
      else
        format.html { render action: 'new' }
        format.json { render json: @administrator.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @administrator.update(administrator_params)
        format.html { redirect_to @administrator, notice: 'Administrator was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @administrator.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @administrator.destroy
    respond_to do |format|
      format.html { redirect_to administrators_url }
      format.json { head :no_content }
    end
  end

  def welcome
    @total_orders = Order.count
  end
  
  private
    def set_administrator
      @administrator = Administrator.find(params[:id])
    end

    def administrator_params
      params.require(:administrator).permit(:name, :username, :password, :password_confirmation)
    end
end
