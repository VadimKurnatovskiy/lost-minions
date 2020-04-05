module Authorization
  extend ActiveSupport::Concern

  included do
    include Pundit
    protect_from_forgery with: :null_session, if: -> { request.format.json? }
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  end

  private

  def user_not_authorized
    if request.xhr?
      render json: { error: I18n.t('errors.messages.access_denied') }, status: 404
    else
      flash[:alert] = I18n.t('errors.messages..access_denied')
      redirect_to root_path
    end
  end

  def record_not_found
    if request.xhr?
      render json: { error: t('errors.messages..record_not_found') }, status: 404
    else
      flash[:alert] = I18n.t('errors.messages..record_not_found')
      redirect_to root_path
    end
  end
end
