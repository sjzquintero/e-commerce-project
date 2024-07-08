class Order < ApplicationRecord
  belongs_to :user
  belongs_to :province
  has_many :order_details, dependent: :destroy
  has_many :products, through: :order_details

  validates :user, :date, :total, :status, :province, presence: true

  before_save :calculate_total

  def calculate_total
    subtotal = order_details.sum('quantity * unit_price')
    taxes = subtotal * (province.GST / 100.0 + province.PST / 100.0 + province.HST / 100.0)
    self.total = subtotal + taxes
  end

  def self.ransackable_associations(auth_object = nil)
    ["order_details", "products", "province", "user"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "date", "id", "id_value", "province_id", "status", "total", "updated_at", "user_id"]
  end
end
