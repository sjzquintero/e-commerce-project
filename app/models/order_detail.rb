class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :order, :product, :quantity, :unit_price, presence: true
  validates :quantity, numericality: { greater_than_or_equal_to: 1 }
  validates :unit_price, numericality: { greater_than_or_equal_to: 0 }

  before_validation :set_unit_price

  private

  def set_unit_price
    self.unit_price = product.price if unit_price.nil?
  end
end
