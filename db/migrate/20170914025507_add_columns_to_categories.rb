class AddColumnsToCategories < ActiveRecord::Migration[5.0]
  def change
    add_column :categories, :climate, :string
    add_column :categories, :must_have_items, :string
  end
end
