# frozen_string_literal: true

# OrderDetail represents the details of a specific product within an order.
# It includes the quantity of the product, the unit price, and associations
# with the Order and Product models. This model ensures that the quantity
# is at least 1 and the unit price is non-negative. It also handles setting
# the unit price before validation if it's not already set.
#
# Associations:
# - belongs_to :order
# - belongs_to :product
#
# Validations:
# - quantity: must be present and greater than or equal to 1
# - unit_price: must be present and greater than or equal to 0
#
# Callbacks:
# - before_validation :set_unit_price
#
# Class Methods:
# - ransackable_associations
# - ransackable_attributes
class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :quantity, :unit_price, presence: true
  validates :quantity, numericality: { greater_than_or_equal_to: 1 }
  validates :unit_price, numericality: { greater_than_or_equal_to: 0 }

  before_validation :set_unit_price

  private

  def set_unit_price
    if product.present?
      self.unit_price = product.price if unit_price.nil?
    else
      errors.add(:product, "must be valid")
    end
  end

  class << self
    def ransackable_associations(_auth_object = nil)
      %w[order product]
    end

    def ransackable_attributes(_auth_object = nil)
      %w[created_at id id_value order_id product_id quantity unit_price updated_at]
    end

    private :ransackable_associations, :ransackable_attributes
  end
end
