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
      redirect_to product_path(product), alert: 'You can not get more than 5 units for the same product.'
      return
    end

    @order_detail = @order.order_details.find_or_initialize_by(product: product)

    new_quantity = @order_detail.new_record? ? quantity : @order_detail.quantity + quantity

    if new_quantity > 5
      redirect_to product_path(product), alert: 'You can not get more than 5 units for the same product.'
    else
      @order_detail.quantity = new_quantity
      @order_detail.unit_price = product.price
      @order_detail.save
      @order.save

      redirect_to cart_path, notice: 'Producto added to the cart.'
    end
  end

  def update_quantity
    @order_detail = OrderDetail.find(params[:id])
    new_quantity = params[:order_detail][:quantity].to_i

    if new_quantity > 5
      redirect_to cart_path, alert: 'You can not get more than 5 units for the same product.'
      return
    end

    if @order_detail.update(quantity: new_quantity)
      @order_detail.order.save
      redirect_to cart_path, notice: 'Amount updated succesfully.'
    else
      redirect_to cart_path, alert: 'Error updating the amount.'
    end
  end

  def remove_product
    @order_detail = OrderDetail.find(params[:id])
    @order_detail.destroy
    @order_detail.order.save

    redirect_to cart_path, notice: 'Product removed from the cart.'
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

  def order_params
    params.require(:order).permit(order_details_attributes: [:id, :quantity])
  end
end
