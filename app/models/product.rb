# frozen_string_literal: true

# Product represents an item available for purchase, including its details such as
# name, description, price, stock, and associated images. Each product belongs to
# a category and can be part of multiple orders through order details.
#
# Associations:
# - `belongs_to :category`: Establishes a one-to-one relationship where each product
#   is associated with a single category.
# - `has_many :order_details`: Indicates that each product can have multiple order
#   details associated with it.
# - `has_many :orders, through: :order_details`: Sets up a many-to-many relationship
#   where products can be accessed through the associated order details.
# - `has_many :historical_prices`: Indicates that each product can have multiple
#   historical price records.
# - `has_one_attached :image`: Allows each product to have a single attached image
#   for visual representation.
#
# Validations:
# - `validates :name, presence: true`: Ensures that each product has a name.
# - `validates :description, presence: true`: Ensures that each product has a description.
# - `validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }`:
#   Ensures that the price is present and is a non-negative number.
# - `validates :stock, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }`:
#   Ensures that the stock is present, is an integer, and is a non-negative number.
#
# Scopes:
# - `search_by_keyword`: Filters products by name or description matching the given
#   keyword. Useful for implementing search functionality.
# - `on_sale`: Filters products with a price of 15 or less, indicating they are on sale.
# - `new_products`: Filters products created within the last 2 days, identifying new
#   arrivals.
#
# Class Methods:
# - `self.ransackable_associations`: Returns an array of associations that can be
#   used for searching and filtering with Ransack. This includes `category`,
#   `historical_prices`, `order_details`, and `orders`.
# - `self.ransackable_attributes`: Returns an array of attributes that can be used
#   for searching and filtering with Ransack. This includes `id`, `name`, `description`,
#   `price`, `stock`, `category_id`, `created_at`, and `updated_at`.
class Product < ApplicationRecord
  belongs_to :category
  has_many :order_details, dependent: :destroy
  has_many :orders, through: :order_details
  has_many :historical_prices, dependent: :destroy

  has_one_attached :image

  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :stock, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  scope :search_by_keyword, lambda { |keyword|
    where("name LIKE :keyword OR description LIKE :keyword", keyword: "%#{keyword}%")
  }

  scope :on_sale, -> { where(price: ...15) }

  scope :new_products, -> { where(created_at: 2.days.ago..) }

  def self.ransackable_associations(_auth_object = nil)
    %w[category historical_prices order_details orders]
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[id name description price stock category_id created_at updated_at]
  end
end
