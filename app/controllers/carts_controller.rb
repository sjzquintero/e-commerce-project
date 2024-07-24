# frozen_string_literal: true

# CartsController manages the shopping cart functionality for users,
# allowing them to view, add, update, and remove products in their cart.
# It also handles the checkout process where users can finalize their order.
class CartsController < ApplicationController
  # Ensure the user is authenticated before accessing any cart actions.
  before_action :authenticate_user!

  # Displays the current order (shopping cart) for the logged-in user.
  def show
    @order = current_order
  end

  # Adds a product to the cart. If the product is already in the cart,
  # it increases the quantity. A maximum of 5 units per product is allowed.
  # Redirects with an alert if the quantity exceeds the limit.
  def add_product
    product = Product.find(params[:product_id])
    @order = current_order
    quantity = params[:quantity].to_i

    if quantity > 5
      redirect_to product_path(product), alert: t("carts.alerts.cannot_add_more_than_5")
      return
    end

    @order_detail = @order.order_details.find_or_initialize_by(product:)

    new_quantity = @order_detail.new_record? ? quantity : @order_detail.quantity + quantity

    if new_quantity > 5
      redirect_to product_path(product), alert: t("carts.alerts.cannot_add_more_than_5")
    else
      @order_detail.quantity = new_quantity
      @order_detail.unit_price = product.price
      @order_detail.save
      @order.save

      redirect_to cart_path, notice: t("carts.alerts.product_added")
    end
  end

  # Updates the quantity of a specific product in the cart.
  # Ensures that the quantity does not exceed 5 units.
  def update_quantity
    @order_detail = OrderDetail.find(params[:id])
    new_quantity = params[:order_detail][:quantity].to_i

    if new_quantity > 5
      redirect_to cart_path, alert: t("carts.alerts.cannot_have_more_than_5")
      return
    end

    if @order_detail.update(quantity: new_quantity)
      @order_detail.order.save
      redirect_to cart_path, notice: t("carts.alerts.quantity_updated")
    else
      redirect_to cart_path, alert: t("carts.alerts.error_updating_quantity")
    end
  end

  # Removes a product from the cart.
  def remove_product
    @order_detail = OrderDetail.find(params[:id])
    @order_detail.destroy
    @order_detail.order.save

    redirect_to cart_path, notice: t("carts.alerts.product_removed")
  end

  # Initiates the checkout process by ensuring the cart is not empty.
  # Redirects with an alert if the cart is empty.
  def checkout
    @order = current_order

    return unless @order.order_details.empty?

    redirect_to cart_path, alert: t("carts.alerts.cart_empty")
  end

  # Finalizes the checkout process, completing the order and updating user details
  # if necessary. Clears the current order session upon successful checkout.
  def process_checkout
    @order = current_order
    @order.attributes = order_params

    current_user.update(address: @order.address, province: @order.province) if current_user.address.blank? || current_user.province.blank?

    @order.status = "completed"
    if @order.save
      session[:order_id] = nil # Clear the order session
      redirect_to root_path, notice: t("carts.alerts.order_completed")
    else
      render :checkout
    end
  end

  private

  # Retrieves the current order for the user from the session,
  # or creates a new order if none exists.
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

  # Creates a new order with default attributes for the current user
  # and saves it without validation.
  def create_new_order
    order = Order.new(user: current_user, date: Time.zone.today, status: "pending", province: current_user.province)
    order.save(validate: false)
    session[:order_id] = order.id
    order
  end

  # Strong parameters for order updates, allowing nested attributes for order details.
  def order_params
    params.require(:order).permit(:address, :province_id, order_details_attributes: %i[id quantity])
  end
end
