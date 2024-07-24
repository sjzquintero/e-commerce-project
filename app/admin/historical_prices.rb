# frozen_string_literal: true

ActiveAdmin.register HistoricalPrice do
  permit_params :product_id, :price, :effective_date

  index do
    selectable_column
    id_column
    column :product
    column :price
    column :effective_date
    actions
  end

  form do |f|
    f.inputs do
      f.input :product
      f.input :price
      f.input :effective_date
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :product
      row :price
      row :effective_date
    end
  end

  filter :product
  filter :price
  filter :effective_date
end
