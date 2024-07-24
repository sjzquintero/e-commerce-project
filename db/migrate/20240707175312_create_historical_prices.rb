# frozen_string_literal: true

class CreateHistoricalPrices < ActiveRecord::Migration[7.1]
  def change
    create_table :historical_prices do |t|
      t.integer :product_id
      t.decimal :price
      t.datetime :effective_date

      t.timestamps
    end
  end
end
