# frozen_string_literal: true

ActiveAdmin.register OrderDetail do
  permit_params :order_id, :product_id, :quantity, :unit_price

  index do
    selectable_column
    id_column
    column :order
    column :product
    column :quantity
    column :unit_price
    actions
  end

  form do |f|
    f.inputs do
      f.input :order
      f.input :product
      f.input :quantity
      f.input :unit_price
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :order
      row :product
      row :quantity
      row :unit_price
    end
  end

  filter :order
  filter :product
  filter :quantity
  filter :unit_price
end
