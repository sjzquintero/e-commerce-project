ActiveAdmin.register Product do
  permit_params :name, :description, :price, :stock, :category_id

  index do
    selectable_column
    id_column
    column :name
    column :description
    column :price
    column :stock
    column :category
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :price
      f.input :stock
      f.input :category
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
    end
  end

  filter :name
  filter :description
  filter :price
  filter :stock
  filter :category
end
