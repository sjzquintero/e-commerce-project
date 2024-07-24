# frozen_string_literal: true

ActiveAdmin.register Product do
  permit_params :name, :description, :price, :stock, :category_id, :image

  index do
    selectable_column
    id_column
    column :name
    column :description
    column :price
    column :stock
    column :category
    column :image do |product|
      image_tag url_for(product.image), size: '100x100' if product.image.attached?
    end
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :price
      f.input :stock
      f.input :category
      f.input :image, as: :file
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :name
      row :description
      row :price
      row :stock
      row :category
      row :image do |product|
        image_tag url_for(product.image), size: '300x300' if product.image.attached?
      end
    end
  end

  filter :name
  filter :description
  filter :price
  filter :stock
  filter :category
end
