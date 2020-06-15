# frozen_string_literal: true

module Pets
  module Filterable
    DEFAULT_PAGE = 1
    PAGE_SIZE = 9

    def api_filter_params
      {
        situation: params[:situation],
        pagination: pagination_params,
        breed: params[:breed_id],
        gender: params[:gender],
        address: params[:address],
        near: near_api_params
      }
    end

    def web_filter_params(situation:)
      {
        pagination: pagination_params,
        breed: params[:breed_id],
        gender: params[:gender],
        address: params[:address],
        near: near_params
      }.merge(situation: situation)
    end

    private

    def pagination_params
      {
        page: params[:page] || DEFAULT_PAGE,
        per_page: PAGE_SIZE
      }
    end

    def near_params
      {
        radius: params[:distance],
        latitude: params[:latitude] || current_coordinates[0],
        longitude: params[:longitude] || current_coordinates[1]
      }
    end

    def near_api_params
      {
        radius: params[:distance],
        latitude: params[:latitude],
        longitude: params[:longitude]
      }
    end
  end
end
