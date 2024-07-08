class Category < ApplicationRecord
  has_many :products

  validates :name, presence: true
  validates :description, presence: true

  # Método ransackable_associations
  def self.ransackable_associations(auth_object = nil)
    %w[products]
  end

  # Método ransackable_attributes
  def self.ransackable_attributes(auth_object = nil)
    %w[id name description created_at updated_at]
  end
end
