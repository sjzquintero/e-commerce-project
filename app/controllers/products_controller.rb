class ProductsController < ApplicationController
  def index
    @products = Product.page(params[:page]).per(10)
  end

  def by_category
    @category = Category.find(params[:id])
    @products = @category.products.page(params[:page]).per(10)
  end

  def show
    @product = Product.find(params[:id])
  end
end
