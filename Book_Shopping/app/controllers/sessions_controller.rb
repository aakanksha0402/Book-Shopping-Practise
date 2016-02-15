class SessionsController < ApplicationController
  include CreateCart
  before_action :cart_assign
  def new
  end

  def create
    admin = Administrator.find_by_username(params[:username])
    if admin && admin.authenticate(params[:password])
      session[:admin_id] = admin.id
      redirect_to '/administrators/welcome'
    else
      redirect_to sessions_new_path
    end
  end

  def destroy
    session[:admin_id] = nil
    redirect_to '/'
  end
end
