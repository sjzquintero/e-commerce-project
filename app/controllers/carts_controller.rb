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
      redirect_to product_path(product), alert: 'You cannot add more than 5 units of the same product.'
      return
    end

    @order_detail = @order.order_details.find_or_initialize_by(product: product)

    new_quantity = @order_detail.new_record? ? quantity : @order_detail.quantity + quantity

    if new_quantity > 5
      redirect_to product_path(product), alert: 'You cannot add more than 5 units of the same product.'
    else
      @order_detail.quantity = new_quantity
      @order_detail.unit_price = product.price
      @order_detail.save
      @order.save

      redirect_to cart_path, notice: 'Product added to the cart.'
    end
  end

  def update_quantity
    @order_detail = OrderDetail.find(params[:id])
    new_quantity = params[:order_detail][:quantity].to_i

    if new_quantity > 5
      redirect_to cart_path, alert: 'You cannot have more than 5 units of the same product.'
      return
    end

    if @order_detail.update(quantity: new_quantity)
      @order_detail.order.save
      redirect_to cart_path, notice: 'Quantity updated successfully.'
    else
      redirect_to cart_path, alert: 'Error updating the quantity.'
    end
  end

  def remove_product
    @order_detail = OrderDetail.find(params[:id])
    @order_detail.destroy
    @order_detail.order.save

    redirect_to cart_path, notice: 'Product removed from the cart.'
  end

  def checkout
    @order = current_order

    if @order.order_details.empty?
      redirect_to cart_path, alert: "Your cart is empty. Please add some items before checking out."
    end
  end

  def process_checkout
    @order = current_order
    @order.attributes = order_params

    if current_user.address.blank? || current_user.province.blank?
      current_user.update(address: @order.address, province: @order.province)
    end

    @order.status = 'completed'
    if @order.save
      session[:order_id] = nil # Clear the order session
      redirect_to root_path, notice: 'Order completed successfully.'
    else
      render :checkout
    end
  end

  private

  def current_order
    if session[:order_id].present?
      begin
        Order.find(session[:order_id])
      rescue ActiveRecord::RecordNotFound
        create_new_order
      end
    else
      create_new_order
    end
  end

  def create_new_order
    order = Order.new(user: current_user, date: Date.today, status: 'pending', province: current_user.province)
    order.save(validate: false)
    session[:order_id] = order.id
    order
  end

  def order_params
    params.require(:order).permit(:address, :province_id, order_details_attributes: [:id, :quantity])
  end
end
