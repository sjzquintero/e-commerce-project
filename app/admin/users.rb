ActiveAdmin.register User do
  permit_params :name, :email, :password, :address, :province_id, :avatar

  index do
    selectable_column
    id_column
    column :name
    column :email
    column :address
    column :province
    column :avatar do |user|
      if user.avatar.attached?
        image_tag user.avatar.variant(resize_to_limit: [100, 100]), class: 'thumbnail'
      else
        "No image"
      end
    end
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :email
      f.input :password
      f.input :address
      f.input :province
      f.input :avatar, as: :file
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :name
      row :email
      row :address
      row :province
      row :avatar do |user|
        if user.avatar.attached?
          image_tag user.avatar.variant(resize_to_limit: [200, 200]), class: 'thumbnail'
        else
          "No image"
        end
      end
    end
  end

  filter :name
  filter :address
  filter :province
end
