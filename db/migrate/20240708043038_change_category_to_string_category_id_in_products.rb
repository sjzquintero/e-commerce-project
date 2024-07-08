class ChangeCategoryToStringCategoryIdInProducts < ActiveRecord::Migration[7.1]
  def change
    rename_column :products, :category, :category_id
    change_column :products, :category_id, :integer
  end
end
