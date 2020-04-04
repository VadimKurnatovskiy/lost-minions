# frozen_string_literal: true

Timezone::Lookup.config(:geonames) do |c|
  c.username = ENV.fetch('GEOCODES_ACC_USERNAME')
end

Timezone::Lookup.config(:google) do |c|
  c.api_key = ENV.fetch('GOOGLE_API_KEY')
end
