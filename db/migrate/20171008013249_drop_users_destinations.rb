class DropUsersDestinations < ActiveRecord::Migration[5.0]
  def change
    drop_table :users_destinations
  end
end
