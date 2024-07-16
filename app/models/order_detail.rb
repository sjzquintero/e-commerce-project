# app/models/order_detail.rb
class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :order, :product, :quantity, :unit_price, presence: true
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

  def self.ransackable_associations(auth_object = nil)
    ["order", "product"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "id_value", "order_id", "product_id", "quantity", "unit_price", "updated_at"]
  end
end
