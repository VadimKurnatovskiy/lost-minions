# frozen_string_literal: true

class PetQuery
  DEFAULT_RADIUS = 100
  ALLOWED_PARAMS = %i[situation breed gender address near].freeze

  attr_reader :relation

  def initialize(relation = Pet.all)
    @relation = relation.includes(:breed, :user).with_attached_pictures
  end

  def filter(params = {})
    result = params.slice(*ALLOWED_PARAMS).reduce(relation) do |relation, (key, value)|
      next relation if value.blank?

      send("by_#{key}", relation, value)
    end

    paginate(result, params[:pagination])
  end

  private

  def paginate(result, params)
    return result unless params.present?

    result.page(params[:page]).per(params[:per_page])
  end

  def by_situation(relation, situation)
    relation.where(situation: situation)
  end

  def by_breed(relation, breed)
    relation.where(breed_id: breed)
  end

  def by_gender(relation, gender)
    relation.where(gender: gender)
  end

  def by_near(relation, near_params)
    return relation unless searching_area?(near_params)

    relation.near([near_params[:latitude], near_params[:longitude]], near_params[:radius].presence || DEFAULT_RADIUS)
  end

  def by_address(relation, address)
    relation.where('LOWER(address) LIKE ?', "%#{address.downcase}%")
  end

  def searching_area?(params)
    params[:latitude].present? && params[:longitude].present?
  end
end
