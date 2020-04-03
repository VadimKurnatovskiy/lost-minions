# frozen_string_literal: true

require_relative 'boot'

require 'rails'
require 'active_model/railtie'
require 'active_record/railtie'
require 'active_storage/engine'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'sprockets/railtie'

Bundler.require(*Rails.groups)

module LostMinions
  class Application < Rails::Application
    config.load_defaults 5.2
    config.generators.system_tests = nil
    config.time_zone = 'UTC'
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.yml').to_s]
    config.i18n.available_locales = %i[en ru]
    config.i18n.fallbacks = %i[en ru]
    config.i18n.default_locale = :ru
    config.action_mailer.default_options = { from: ENV.fetch('EMAIL_SENDER') }
  end
end
