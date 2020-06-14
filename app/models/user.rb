# frozen_string_literal: true

class User < ApplicationRecord
  extend Enumerize
  include DeviseTokenAuth::Concerns::User

  OMNIAUTH_PROVIDERS = %i[google_oauth2].freeze
  AVAILABLE_LOCALES = Rails.configuration.i18n.available_locales.map(&:to_s)

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :trackable, :omniauthable,
         omniauth_providers: OMNIAUTH_PROVIDERS

  enumerize :language, in: AVAILABLE_LOCALES
  enum role: { user: 'user', admin: 'admin' }

  has_many :pets

  validates :first_name, :role, :call_time_from, :call_time_to, presence: true
  validates :phone_number, presence: true, unless: :omniauth?
  validates :language, inclusion: { in: AVAILABLE_LOCALES }, allow_blank: true
  before_create :set_default_call_time

  def self.from_omniauth(auth) # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    where(email: auth.info.email).first_or_create do |user|
      user.uid = auth.uid
      user.provider = auth.provider
      user.password = Devise.friendly_token[0, 20]
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.picture_url = auth.info.image
      user.call_time_from = Time.utc(2020, 5, 6, 9)
      user.call_time_to = Time.utc(2020, 5, 6, 21)
      user.skip_confirmation!
    end
  end

  def omniauth?
    OMNIAUTH_PROVIDERS.include?(provider.to_sym)
  end

  def deactivate!
    update(deactivated_at: Time.current)
    update_pets(deactivated_at: Time.current)
  end

  def reactivate!
    return unless deactivated_at?

    update(deactivated_at: nil)
    update_pets(deactivated_at: nil)
  end

  private

  def update_pets(**attributes)
    pets.with_deactivated.each do |pet|
      pet.update(attributes)
    end
  end

  def set_default_call_time
    self.call_time_from = Time.utc(2020, 5, 6, 9)
    self.call_time_to = Time.utc(2020, 5, 6, 21)
  end
end
