# frozen_string_literal: true

# Category represents a product category within the application. It is associated
# with multiple products and provides validation for the presence of required
# attributes such as name and description.
#
# Associations:
# - `has_many :products`: Establishes a one-to-many relationship where each category
#   can have multiple products associated with it.
#
# Validations:
# - `validates :name, presence: true`: Ensures that each category has a name.
# - `validates :description, presence: true`: Ensures that each category has a description.
#
# Class Methods:
# - `self.ransackable_associations`: Returns an array of associations that can be
#   used for searching and filtering with Ransack.
# - `self.ransackable_attributes`: Returns an array of attributes that can be used
#   for searching and filtering with Ransack.
class Category < ApplicationRecord
  has_many :products, dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true

  # Specifies which associations are searchable with Ransack. This method allows
  # the `products` association to be used in Ransack search queries.
  #
  # @param _auth_object [Object, nil] Optional authentication object.
  # @return [Array<String>] List of associations available for search.
  def self.ransackable_associations(_auth_object = nil)
    %w[products]
  end

  # Specifies which attributes are searchable with Ransack. This method allows
  # the `id`, `name`, `description`, `created_at`, and `updated_at` attributes
  # to be used in Ransack search queries.
  #
  # @param _auth_object [Object, nil] Optional authentication object.
  # @return [Array<String>] List of attributes available for search.
  def self.ransackable_attributes(_auth_object = nil)
    %w[id name description created_at updated_at]
  end
end
