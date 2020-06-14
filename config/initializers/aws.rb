# frozen_string_literal: true

require 'aws-sdk-s3'

# rubocop:disable Style/BracesAroundHashParameters, Layout/IndentFirstHashElement
Aws.config.update({
  region: ENV.fetch('AWS_REGION', 'eu-central-1'),
  credentials: Aws::Credentials.new(ENV.fetch('AWS_ACCESS_KEY_ID', 'id'), ENV.fetch('AWS_SECRET_ACCESS_KEY', 'key'))
})
# rubocop:enable Style/BracesAroundHashParameters, Layout/IndentFirstHashElement

S3_BUCKET = Aws::S3::Resource.new.bucket(ENV.fetch('AWS_BUCKET', 'bucket'))
