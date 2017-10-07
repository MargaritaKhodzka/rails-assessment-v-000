class CreateUsersDestinations < ActiveRecord::Migration[5.0]
  def change
    create_table :users_destinations do |t|
      t.integer :user_id
      t.integer :destination_id
      t.boolean :visited

      t.timestamps
    end
  end
end
