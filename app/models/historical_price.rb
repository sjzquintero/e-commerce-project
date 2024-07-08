class HistoricalPrice < ApplicationRecord
  belongs_to :product

  validates :product, :price, :effective_date, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  def self.ransackable_associations(auth_object = nil)
    ["product"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "effective_date", "id", "id_value", "price", "product_id", "updated_at"]
  end

end
