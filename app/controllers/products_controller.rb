class ProductsController < ApplicationController
  def index
    @products = Product.all
    @products = @products.search_by_keyword(params[:search]) if params[:search].present?
    @products = @products.where(category_id: params[:category_id]) if params[:category_id].present?
    @products = @products.page(params[:page]).per(10)
  end

  def by_category
    @category = Category.find(params[:id])
    @products = @category.products.page(params[:page]).per(10)
  end

  def show
    @product = Product.find(params[:id])
  end
end
