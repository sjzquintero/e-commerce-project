class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def by_category
    @category = Category.find(params[:id])
    @products = @category.products
  end
end
