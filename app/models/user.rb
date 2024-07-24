# frozen_string_literal: true

# User represents an individual who can register, log in, and manage their
# orders within the application. Each user is associated with a province and
# can have multiple orders.
#
# Associations:
# - `has_one_attached :avatar`: Allows each user to have a single attached avatar
#   image for personal representation.
# - `belongs_to :province`: Indicates that each user is associated with a single
#   province.
# - `has_many :orders`: Indicates that each user can have multiple orders.
#
# Devise Modules:
# - `:database_authenticatable`: Handles authentication using a database.
# - `:registerable`: Manages user registration.
# - `:recoverable`: Allows users to reset their passwords.
# - `:rememberable`: Manages remembering users across sessions.
# - `:validatable`: Provides validations for user attributes such as email and password.
#
# Validations:
# - `validates :name, :password, presence: true`: Ensures that each user has a name
#   and a password before being saved to the database.
#
# Class Methods:
# - `self.ransackable_attributes`: Returns an array of attributes that can be
#   used for searching and filtering with Ransack. This includes `address`, `created_at`,
#   `id`, `id_value`, `name`, `password`, `province_id`, and `updated_at`.
# - `self.ransackable_associations`: Returns an array of associations that can be
#   used for searching and filtering with Ransack. This includes `orders` and `province`.
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one_attached :avatar
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :province
  has_many :orders, dependent: :destroy

  validates :name, :password, presence: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[address created_at id id_value name password province_id updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[orders province]
  end
end
