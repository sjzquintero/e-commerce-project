ActiveAdmin.register Order do
  permit_params :user_id, :date, :total, :status, :province_id, :address

  index do
    selectable_column
    id_column
    column :user
    column :date
    column :total
    column :status
    column :province
    column :address
    actions
  end

  form do |f|
    f.inputs do
      f.input :user
      f.input :date
      f.input :total
      f.input :status
      f.input :province
      f.input :address
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :user
      row :date
      row :total
      row :status
      row :province
      row :address
    end
  end

  filter :user
  filter :date
  filter :total
  filter :status
  filter :province
  filter :address
end
