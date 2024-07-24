# frozen_string_literal: true

# AdminUser represents an administrative user in the application and
# includes authentication functionality provided by the Devise gem.
# This model allows administrative users to sign in, recover passwords,
# and manage their sessions.
#
# The `devise` method includes the following default Devise modules:
# - `:database_authenticatable`: Handles authentication with encrypted passwords.
# - `:recoverable`: Provides password recovery functionality.
# - `:rememberable`: Manages user sessions by remembering the user.
# - `:validatable`: Validates email and password fields.
#
# The `ransackable_attributes` class method specifies which attributes can
# be used for searching and filtering with Ransack, an advanced search
# library for Rails.
class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  # Specifies the attributes that can be used for searching and filtering
  # with Ransack. This method allows the attributes to be dynamically
  # searched in admin interfaces or other search functionalities.
  #
  # @param _auth_object [Object, nil] Optional authentication object.
  # @return [Array<String>] List of attributes available for search.
  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at email encrypted_password id id_value remember_created_at
       reset_password_sent_at reset_password_token updated_at]
  end
end
