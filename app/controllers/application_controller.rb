# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Geolocation
  include Timezonable
  include Localization

  protect_from_forgery with: :null_session, if: -> { request.format.json? }

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name phone_number])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[first_name last_name phone_number timezone language])
  end
end
