# frozen_string_literal: true

class AddAddressToOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :address, :string
  end
end
