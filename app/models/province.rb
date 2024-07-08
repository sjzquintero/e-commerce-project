class Province < ApplicationRecord
  has_many :users
  has_many :orders

  validates :name, :GST, :PST, :HST, presence: true
  validates :GST, :PST, :HST, numericality: { greater_than_or_equal_to: 0 }

  def self.ransackable_associations(auth_object = nil)
    ["orders", "users"]
  end
  def self.ransackable_attributes(auth_object = nil)
    ["GST", "HST", "PST", "created_at", "id", "id_value", "name", "updated_at"]
  end
end
