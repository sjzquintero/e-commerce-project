class User < ApplicationRecord
  belongs_to :province
  has_many :orders

  validates :name, :email, :address, presence: true
  validates :email, uniqueness: true
end
