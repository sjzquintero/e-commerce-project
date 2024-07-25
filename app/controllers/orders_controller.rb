class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = current_user.orders.completed.order(created_at: :desc)
  end

  def show
    @order = current_user.orders.completed.find(params[:id])
  end
end
