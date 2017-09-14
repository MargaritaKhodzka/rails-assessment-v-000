class DropCreateUserDestinations < ActiveRecord::Migration[5.0]
  def change
    drop_table :create_user_destinations
  end
end
