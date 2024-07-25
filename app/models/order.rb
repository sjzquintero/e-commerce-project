# frozen_string_literal: true

# Order represents a purchase made by a user, including details about the order
# such as the total amount, the date of the order, and the status. Each order
# is associated with a user and a province, and it contains multiple order details
# and products.
#
# Associations:
# - `belongs_to :user`: Establishes a one-to-one relationship where each order
#   is associated with a single user.
# - `belongs_to :province`: Establishes a one-to-one relationship where each
#   order is associated with a single province, which influences the tax calculations.
# - `has_many :order_details, dependent: :destroy`: Indicates that each order
#   can have multiple order details. When an order is destroyed, its associated
#   order details are also removed.
# - `has_many :products, through: :order_details`: Sets up a many-to-many relationship
#   where products can be accessed through the associated order details.
#
# Validations:
# - `validates :date, :total, :status, :address, presence: true`: Ensures that the
#   date, total amount, status, and address are present for each order.
#
# Callbacks:
# - `before_save :calculate_total`: Automatically calculates the total amount of the
#   order before saving it.
#
# Nested Attributes:
# - `accepts_nested_attributes_for :order_details, allow_destroy: true`: Allows
#   order details to be created, updated, or destroyed along with the order.
#
# Instance Methods:
# - `calculate_total`: Calculates the total amount of the order by summing the
#   subtotal of the order details and adding the taxes.
# - `taxes`: Calculates the tax amount based on the province's GST, PST, and HST rates.
#
# Class Methods:
# - `self.ransackable_associations`: Returns an array of associations that can be
#   used for searching and filtering with Ransack. In this case, it allows searching
#   through `order_details`, `products`, `province`, and `user`.
# - `self.ransackable_attributes`: Returns an array of attributes that can be used
#   for searching and filtering with Ransack. This includes attributes like `created_at`,
#   `date`, `id`, `province_id`, `status`, `total`, `updated_at`, `user_id`, and `address`.
class Order < ApplicationRecord
  belongs_to :user
  belongs_to :province
  has_many :order_details, dependent: :destroy
  has_many :products, through: :order_details

  validates :date, :total, :status, :address, presence: true

  before_save :calculate_total

  accepts_nested_attributes_for :order_details, allow_destroy: true

  scope :completed, -> { where(status: "completed") }

  def calculate_total
    subtotal = order_details.sum("quantity * unit_price")
    self.total = subtotal + taxes
  end

  def taxes
    subtotal = order_details.sum("quantity * unit_price")
    subtotal * ((province.GST / 100.0) + (province.PST / 100.0) + (province.HST / 100.0))
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[order_details products province user]
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at date id id_value province_id status total updated_at user_id address]
  end
end
