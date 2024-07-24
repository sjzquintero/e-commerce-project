# frozen_string_literal: true

ActiveAdmin.register Province do
  permit_params :name, :GST, :PST, :HST

  index do
    selectable_column
    id_column
    column :name
    column :GST
    column :PST
    column :HST
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :GST
      f.input :PST
      f.input :HST
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :name
      row :GST
      row :PST
      row :HST
    end
  end

  filter :name
  filter :GST
  filter :PST
  filter :HST
end
