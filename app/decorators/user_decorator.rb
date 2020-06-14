# frozen_string_literal: true

class UserDecorator < ApplicationDecorator
  delegate :id, :email, :phone_number, :first_name, :last_name, :language, :timezone, :picture_url,
           :admin?, :role

  def full_name
    "#{object.first_name} #{object.last_name}"
  end

  def full_name_with_email
    "#{object.full_name} (#{object.email})"
  end

  def availability
    "#{l(object.call_time_from, format: :time)} - #{l(object.call_time_to, format: :time)}"
  end
end
