module AdminScope
  class ApplicationController < ActionController::Base
    before_action :authenticate_user!
    before_action :require_admin

    layout "admin"

    private

    def require_admin
      unless current_user && current_user.admin?
        flash[:error] = 'Permissions denied'
        redirect_to root_path
      end
    end
  end
end
