# frozen_string_literal: true

module Api
  module V1
    module Me
      class PetsController < ApiController
        include ::Pets::Filterable

        def index
          render json: PetQuery.new(current_user.pets, api_filter_params)
                               .all
                               .page(params[:page]).per(params[:per_page])
                               .sorted_by_creation_date(:desc)
        end
      end
    end
  end
end
