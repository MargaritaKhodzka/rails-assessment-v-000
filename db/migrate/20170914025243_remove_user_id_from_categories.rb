class RemoveUserIdFromCategories < ActiveRecord::Migration[5.0]
  def change
    remove_column :categories, :user_id, :integer
  end
end
