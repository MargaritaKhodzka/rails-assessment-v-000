class AddVisitedToDestination < ActiveRecord::Migration[5.0]
  def change
    add_column :destinations, :visited, :boolean, default: false
  end
end
