class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_locale_from_params

  private

  def set_locale_from_params
    if params[:locale]
      if I18n.available_locales.map(&:to_s).include?(params[:locale])
        I18n.locale = params[:locale]
      else
        flash.now[:notice] =
        "#{params[:locale]} translation not available"
        logger.error flash.now[:notice]
      end
    end
  end

  def default_url_options
  { locale: I18n.locale }
  end

  def current_admin
    @admin_details ||= Administrator.find(session[:admin_id]) if session[:admin_id]
  end
  helper_method :current_admin

  def authorize
  redirect_to '/' unless current_admin
  end
end
