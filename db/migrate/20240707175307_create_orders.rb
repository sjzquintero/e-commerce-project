class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.datetime :date
      t.decimal :total
      t.string :status
      t.integer :province_id

      t.timestamps
    end
  end
end
