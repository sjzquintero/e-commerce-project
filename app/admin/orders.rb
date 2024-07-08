ActiveAdmin.register Order do
  permit_params :user_id, :date, :total, :status, :province_id

  index do
    selectable_column
    id_column
    column :user
    column :date
    column :total
    column :status
    column :province
    actions
  end

  form do |f|
    f.inputs do
      f.input :user
      f.input :date
      f.input :total
      f.input :status
      f.input :province
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
    end
  end

  filter :user
  filter :date
  filter :total
  filter :status
  filter :province
end
