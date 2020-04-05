# frozen_string_literal: true

ActiveAdmin.setup do |config|
  config.site_title = 'Lost Minions'

  config.authentication_method = :authenticate_active_admin_user!
  config.current_user_method = :current_user
  config.logout_link_method = :delete
  config.logout_link_path = :destroy_user_session_path
  config.comments = false
  config.batch_actions = true
  config.localize_format = :long
  config.footer = 'Lost Minions v1.0'
  config.favicon = '/assets/favicon.png'
end
