class ProductsController < ApplicationController

  def index
    @products = Product.page(params[:page]).per(10)
  end

  def show
    @product = Product.find(params[:id])
  end

  def by_category
    @category = Category.find(params[:id])
    @products = @category.products.page(params[:page]).per(10)
  end

  def search
    if params[:query].present?
      query = "%#{params[:query].downcase}%"
      @products = Product.where('LOWER(name) LIKE ? OR LOWER(description) LIKE ?', query, query).page(params[:page]).per(10)
    else
      @products = Product.all.page(params[:page]).per(10)
    end
  end
end
