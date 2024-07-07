class CreateProvinces < ActiveRecord::Migration[7.1]
  def change
    create_table :provinces do |t|
      t.string :name
      t.float :GST
      t.float :PST
      t.float :HST

      t.timestamps
    end
  end
end
