# frozen_string_literal: true

ActiveAdmin.register StaticPage do
  permit_params :title, :content

  form do |f|
    f.inputs do
      f.input :title
      f.input :content, as: :text
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :title
    actions
  end

  show do
    attributes_table do
      row :title
      row :content do |page|
        sanitize(page.content)
      end
    end
  end

  filter :title
end
