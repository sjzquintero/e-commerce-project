# frozen_string_literal: true

# The `Users::RegistrationsController` class extends Devise's built-in
# `RegistrationsController` to customize the user registration process.
# This customization allows for additional user information, such as name,
# address, province, and avatar, to be included during registration.
#
# This controller ensures that Devise's default parameter sanitizer is extended
# to include these custom fields, enabling more detailed user profiles.
#

module Users
  # Controller Actions:
  # - `configure_permitted_parameters`: Adds custom parameters to Devise's
  #   sanitizer to allow additional user information (name, address, province_id, avatar)
  #   to be included during user sign-up.
  class RegistrationsController < Devise::RegistrationsController
    # Ensures that additional parameters are permitted when using Devise's registration features.
    before_action :configure_permitted_parameters, if: :devise_controller?

    protected

    # Configures the permitted parameters for user sign-up. This method extends Devise's default
    # parameter sanitizer to include custom fields: name, address, province_id, and avatar.
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: %i[name address province_id avatar])
    end
  end
end
