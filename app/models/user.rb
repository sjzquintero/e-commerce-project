class User < ApplicationRecord
  belongs_to :province
  has_many :orders

  validates :name, :email, :address, presence: true
  validates :email, uniqueness: true

  def self.ransackable_attributes(auth_object = nil)
    ["address", "created_at", "email", "id", "id_value", "name", "password", "province_id", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["orders", "province"]
  end

end
