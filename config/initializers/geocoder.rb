# frozen_string_literal: true

Geocoder.configure(
  # Geocoding options
  timeout: 500,
  lookup: :google,
  # language: :en,
  use_https: true,
  api_key: ENV['GOOGLE_MAPS_API_KEY'],
  always_raise: :all,
  units: :km
)
