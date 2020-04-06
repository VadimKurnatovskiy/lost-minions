# frozen_string_literal: true

class AttachmentsController < ApplicationController
  before_action :fetch_attachment, only: %i[destroy]

  def destroy
    @attachment.purge

    redirect_back(fallback_location: request.referer)
  end

  private

  def fetch_attachment
    @attachment = if current_user.admin?
      ActiveStorage::Attachment.find(params[:id])
    else
      ActiveStorage::Attachment.where(record: current_user.pets).find(params[:id])
    end
  end
end
