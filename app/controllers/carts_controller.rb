# app/controllers/carts_controller.rb
class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    @order = current_order
  end

  def add_product
    product = Product.find(params[:product_id])
    @order = current_order
    @order_detail = @order.order_details.find_or_initialize_by(product: product)

    if @order_detail.new_record?
      @order_detail.quantity = 1
      @order_detail.unit_price = product.price
    else
      @order_detail.quantity += 1
    end

    @order_detail.save
    @order.save

    redirect_to cart_path, notice: 'Producto añadido al carrito.'
  end

  private

  def current_order
    if session[:order_id].present?
      Order.find(session[:order_id])
    else
      order = Order.new(user: current_user, date: Date.today, status: 'pending', province: current_user.province)
      order.save(validate: false)
      session[:order_id] = order.id
      order
    end
  end
end
