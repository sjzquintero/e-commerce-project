# frozen_string_literal: true

# HistoricalPrice represents the price history of a product, including the price
# and the date it became effective. Each historical price record is associated with
# a specific product and provides validation to ensure data integrity.
#
# Associations:
# - `belongs_to :product`: Establishes a one-to-one relationship where each
#   historical price record is associated with a single product.
#
# Validations:
# - `validates :price, :effective_date, presence: true`: Ensures that both
#   the price and the effective date are provided.
# - `validates :price, numericality: { greater_than_or_equal_to: 0 }`: Ensures
#   that the price is a non-negative number.
#
# Class Methods:
# - `self.ransackable_associations`: Returns an array of associations that can
#   be used for searching and filtering with Ransack. In this case, it allows
#   the `product` association to be included in search queries.
# - `self.ransackable_attributes`: Returns an array of attributes that can be
#   used for searching and filtering with Ransack. This includes attributes like
#   `created_at`, `effective_date`, `id`, `price`, `product_id`, and `updated_at`.
class HistoricalPrice < ApplicationRecord
  belongs_to :product

  validates :price, :effective_date, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  # Specifies which associations are searchable with Ransack. This method allows
  # the `product` association to be used in Ransack search queries.
  #
  # @param _auth_object [Object, nil] Optional authentication object.
  # @return [Array<String>] List of associations available for search.
  def self.ransackable_associations(_auth_object = nil)
    ["product"]
  end

  # Specifies which attributes are searchable with Ransack. This method allows
  # the `created_at`, `effective_date`, `id`, `id_value`, `price`, `product_id`,
  # and `updated_at` attributes to be used in Ransack search queries.
  #
  # @param _auth_object [Object, nil] Optional authentication object.
  # @return [Array<String>] List of attributes available for search.
  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at effective_date id id_value price product_id updated_at]
  end
end
