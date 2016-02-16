class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
  
  def current_admin
    @admin_details ||= Administrator.find(session[:admin_id]) if session[:admin_id]
  end
  helper_method :current_admin

  def authorize
  redirect_to '/' unless current_admin
  end
end
