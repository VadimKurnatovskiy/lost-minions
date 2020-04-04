# frozen_string_literal: true

Geocoder.configure(
  # Geocoding options
  timeout: 500,
  ip_lookup: :ipstack,
  ipstack: {
    api_key: ENV['IPSTACK_API_KEY'],
    use_https: false
  },
  lookup: :google,
  # language: :en,
  use_https: true,
  api_key: ENV['GOOGLE_API_KEY'],
  always_raise: :all,
  units: :km
)
