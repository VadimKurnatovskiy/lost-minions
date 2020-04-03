# frozen_string_literal: true

module Timezonable
  extend ActiveSupport::Concern

  included do
    around_action :timezone=
  end

  private

  def timezone=(&block)
    Time.use_zone(timezone, &block)
  end

  def timezone
    current_user&.timezone.presence || geolocation_timezone || 'UTC'
  end

  def geolocation_timezone
    return if current_coordinates.blank?

    Timezone.lookup(*current_coordinates).name
  end
end
