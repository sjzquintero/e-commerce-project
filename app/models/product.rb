class Product < ApplicationRecord
  belongs_to :category
  has_many :order_details
  has_many :orders, through: :order_details
  has_many :historical_prices

  validates :name, :description, :price, :stock, :category, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  before_save :update_historical_price

  private

  def update_historical_price
    if price_changed?
      HistoricalPrice.create(product_id: id, price: price, effective_date: Time.current)
    end
  end
end
