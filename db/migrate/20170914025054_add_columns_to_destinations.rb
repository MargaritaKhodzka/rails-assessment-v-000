class AddColumnsToDestinations < ActiveRecord::Migration[5.0]
  def change
    add_column :destinations, :country, :string
    add_column :destinations, :best_season_to_visit, :string
  end
end
