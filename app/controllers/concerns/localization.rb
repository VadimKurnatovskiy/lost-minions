# frozen_string_literal: true

module Localization
  extend ActiveSupport::Concern

  private

  def set_locale
    I18n.locale = user_locale || geolocation_locale || I18n.default_locale
  end

  def user_locale
    current_user.language.to_sym if current_user.try(:language).present?
  end

  def geolocation_locale
    location = request.location

    return unless location.try(:country_code).present?

    location.country_code == 'RU' ? :ru : :en
  end
end
