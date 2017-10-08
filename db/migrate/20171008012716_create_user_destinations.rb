class CreateUserDestinations < ActiveRecord::Migration[5.0]
  def change
    create_table :user_destinations do |t|
      t.integer :user_id
      t.integer :destination_id
      t.boolean :visited
    end
  end
end
