# frozen_string_literal: true

# Province represents a geographical region that can be associated with users
# and orders. It includes tax rates for GST, PST, and HST, which are used for
# calculating taxes on orders.
#
# Associations:
# - `has_many :users`: Indicates that each province can have multiple users
#   associated with it.
# - `has_many :orders`: Indicates that each province can have multiple orders
#   associated with it.
#
# Validations:
# - `validates :name, :GST, :PST, :HST, presence: true`: Ensures that each province
#   has a name and tax rates for GST, PST, and HST.
# - `validates :GST, :PST, :HST, numericality: { greater_than_or_equal_to: 0 }`:
#   Ensures that the GST, PST, and HST rates are non-negative numbers.
#
# Class Methods:
# - `self.ransackable_associations`: Returns an array of associations that can be
#   used for searching and filtering with Ransack. This includes `orders` and `users`.
# - `self.ransackable_attributes`: Returns an array of attributes that can be used
#   for searching and filtering with Ransack. This includes `GST`, `HST`, `PST`,
#   `created_at`, `id`, `id_value`, `name`, and `updated_at`.
class Province < ApplicationRecord
  has_many :users, dependent: :nullify
  has_many :orders, dependent: :destroy

  validates :name, :GST, :PST, :HST, presence: true
  validates :GST, :PST, :HST, numericality: { greater_than_or_equal_to: 0 }

  def self.ransackable_associations(_auth_object = nil)
    %w[orders users]
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[GST HST PST created_at id id_value name updated_at]
  end
end
