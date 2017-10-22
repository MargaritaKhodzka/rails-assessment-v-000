class DropUserDestinations < ActiveRecord::Migration[5.0]
  def change
    drop_table :user_destinations
  end
end
