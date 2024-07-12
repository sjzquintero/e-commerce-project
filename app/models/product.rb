class Product < ApplicationRecord
  belongs_to :category
  has_many :order_details
  has_many :orders, through: :order_details
  has_many :historical_prices

  has_one_attached :image

  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :stock, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  scope :search_by_keyword, ->(keyword) {
    where("name LIKE :keyword OR description LIKE :keyword", keyword: "%#{keyword}%")
  }

  scope :on_sale, -> { where("price < ?", 15) }


  scope :new_products, -> { where("created_at >= ?", 2.days.ago) }

  def self.ransackable_associations(auth_object = nil)
    %w[category historical_prices order_details orders]
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[id name description price stock category_id created_at updated_at]
  end
end
