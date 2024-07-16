# app/controllers/carts_controller.rb
class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    @order = current_order
  end

  def add_product
    product = Product.find(params[:product_id])
    @order = current_order
    quantity = params[:quantity].to_i

    if quantity > 5
      redirect_to product_path(product), alert: 'No puedes agregar más de 5 unidades del mismo producto.'
      return
    end

    @order_detail = @order.order_details.find_or_initialize_by(product: product)

    new_quantity = @order_detail.new_record? ? quantity : @order_detail.quantity + quantity

    if new_quantity > 5
      redirect_to product_path(product), alert: 'No puedes tener más de 5 unidades del mismo producto en el carrito.'
    else
      @order_detail.quantity = new_quantity
      @order_detail.unit_price = product.price
      @order_detail.save
      @order.save

      redirect_to cart_path, notice: 'Producto añadido al carrito.'
    end
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
