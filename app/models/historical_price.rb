class HistoricalPrice < ApplicationRecord
  belongs_to :product

  validates :product, :price, :effective_date, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
end
