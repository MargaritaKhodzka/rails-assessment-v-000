class RemoveVisitedFromDestinations < ActiveRecord::Migration[5.0]
  def change
    remove_column :destinations, :visited, :boolean
  end
end
