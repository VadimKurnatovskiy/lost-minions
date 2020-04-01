# frozen_string_literal: true

Rails.application.configure do
  config.cache_classes = true
  config.eager_load = true
  config.consider_all_requests_local = false
  config.action_controller.perform_caching = true
  config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?
  config.assets.js_compressor = :uglifier
  config.assets.compile = false
  config.active_storage.service = :amazon
  config.log_level = :debug
  config.log_tags = [:request_id]
  config.action_mailer.perform_caching = false
  config.i18n.fallbacks = I18n.available_locales
  config.active_support.deprecation = :notify
  config.log_formatter = ::Logger::Formatter.new
  config.force_ssl = true
  config.active_record.dump_schema_after_migration = false

  Rails.application.routes.default_url_options[:host] = ENV['HOST']

  if ENV['RAILS_LOG_TO_STDOUT'].present?
    logger = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger = ActiveSupport::TaggedLogging.new(logger)
  end

  # Enable Email delivery via custom SMTP server or via SendGrid by default
  if ENV['SENDGRID_USERNAME'] || ENV['MAILER_USERNAME']
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.default_url_options = { host: ENV['HOST'] }

    config.action_mailer.smtp_settings = {
      authentication: :plain,
      enable_starttls_auto: true,
      openssl_verify_mode: ENV.fetch('SMTP_OPENSSL_VERIFY_MODE', nil),
      address: ENV.fetch('MAILER_ADDRESS', 'smtp.sendgrid.net'),
      port: ENV.fetch('MAILER_PORT', 587),
      domain: ENV.fetch('MAILER_DOMAIN', 'heroku.com'),
      user_name: ENV.fetch('MAILER_USERNAME') { ENV.fetch('SENDGRID_USERNAME') },
      password: ENV.fetch('MAILER_PASSWORD') { ENV.fetch('SENDGRID_PASSWORD') }
    }
  end
end
