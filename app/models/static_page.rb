# frozen_string_literal: true

# StaticPage represents a static content page within the application, such as
# informational or help pages. Each static page has a title and content, which
# are required for its creation.
#
# Validations:
# - `validates :title, :content, presence: true`: Ensures that each static page
#   has both a title and content before it can be saved to the database.
#
# Class Methods:
# - `self.ransackable_attributes`: Returns an array of attributes that can be
#   used for searching and filtering with Ransack. This includes `content`,
#   `created_at`, `id`, `id_value`, `title`, and `updated_at`.
class StaticPage < ApplicationRecord
  validates :title, :content, presence: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[content created_at id id_value title updated_at]
  end
end
