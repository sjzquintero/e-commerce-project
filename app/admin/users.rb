ActiveAdmin.register User do
  permit_params :name, :password, :address, :province_id

  index do
    selectable_column
    id_column
    column :name
    column :address
    column :province
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :password
      f.input :address
      f.input :province
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :name
      row :address
      row :province
    end
  end

  filter :name
  filter :address
  filter :province
end
