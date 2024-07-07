class Province < ApplicationRecord
  has_many :users
  has_many :orders

  validates :name, :GST, :PST, :HST, presence: true
  validates :GST, :PST, :HST, numericality: { greater_than_or_equal_to: 0 }
end
