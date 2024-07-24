# frozen_string_literal: true

# ProductsController manages the display and filtering of products for users.
# It allows users to view all products, filter them by category, search by keyword,
# and see specific product details. It also provides views for products on sale
# and new arrivals.
class ProductsController < ApplicationController
  # Displays a paginated list of products. Supports filtering by search keyword
  # and category. If search parameters are present, the list will be filtered
  # accordingly. Pagination is set to display 10 products per page.
  def index
    @products = Product.all
    @products = @products.search_by_keyword(params[:search]) if params[:search].present?
    @products = @products.where(category_id: params[:category_id]) if params[:category_id].present?
    @products = @products.page(params[:page]).per(10)
  end

  # Displays a paginated list of products that belong to a specific category.
  # The category is identified by the category ID passed as a parameter.
  # Pagination is set to display 10 products per page.
  def by_category
    @category = Category.find(params[:id])
    @products = @category.products.page(params[:page]).per(10)
  end

  # Displays the details of a single product identified by the product ID
  # passed as a parameter.
  def show
    @product = Product.find(params[:id])
  end

  # Displays a paginated list of products that are currently on sale.
  # Pagination is set to display 10 products per page.
  def on_sale
    @products = Product.on_sale.page(params[:page]).per(10)
  end

  # Displays a paginated list of newly arrived products.
  # Pagination is set to display 10 products per page.
  def new_products
    @products = Product.new_products.page(params[:page]).per(10)
  end
end
