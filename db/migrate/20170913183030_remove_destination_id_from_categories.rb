class RemoveDestinationIdFromCategories < ActiveRecord::Migration[5.0]
  def change
    remove_column :categories, :destination_id, :integer
  end
end