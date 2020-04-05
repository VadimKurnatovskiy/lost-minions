class User
  class ParameterSanitizer < Devise::ParameterSanitizer
    USER_PARAMS = %i[
      first_name
      last_name
      email
      phone_number
      password
      password_confirmation
      timezone
      language
    ].freeze

    def initialize(*)
      super
      permit(:sign_up, keys: USER_PARAMS)
      permit(:account_update, keys: USER_PARAMS)
    end
  end
end
