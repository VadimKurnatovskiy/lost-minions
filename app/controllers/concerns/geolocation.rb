# frozen_string_literal: true

module Geolocation
  extend ActiveSupport::Concern

  included do
    def current_coordinates
      @current_coordinates ||= from_cookies || from_request || []
    end
  end

  private

  def from_cookies
    return if cookies[:latitude].blank? || cookies[:longitude].blank?

    [cookies[:latitude], cookies[:longitude]]
  end

  def from_request
    [request.location.latitude, request.location.longitude]
  end
end
