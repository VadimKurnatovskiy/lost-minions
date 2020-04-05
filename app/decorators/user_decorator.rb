class UserDecorator < ApplicationDecorator
  delegate :id, :email, :phone_number, :first_name, :last_name, :language, :timezone, :picture_url

  def full_name
    "#{object.first_name} #{object.last_name}"
  end

  def full_name_with_email
    "#{object.full_name} (#{object.email})"
  end
end
