# frozen_string_literal: true

module TimeHelper
  def current_time
    I18n.l(Time.current, format: :time)
  end

  def timezone
    Time.zone.name
  end

  def timezones_list
    ActiveSupport::TimeZone.all.map(&:name).sort
  end
end
