class AddVisitedToDestinations < ActiveRecord::Migration[5.0]
  def change
    add_column :destinations, :visited, :boolean
  end
end
