# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Geolocation
  include Timezonable
  include Localization
  include Authentication
  include Authorization

  before_action :set_locale

  def authenticate_active_admin_user!
    return if current_user&.admin?

    flash[:alert] = I18n.t('errors.messages.access_denied')
    redirect_to root_path
  end
end
