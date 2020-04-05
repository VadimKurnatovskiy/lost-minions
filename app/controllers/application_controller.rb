# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Geolocation
  include Timezonable
  include Localization
  include Authentication
  include Authorization

  before_action :set_locale
end
