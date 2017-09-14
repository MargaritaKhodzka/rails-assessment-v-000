class CreateCreateUserDestinations < ActiveRecord::Migration[5.0]
  def change
    create_table :create_user_destinations do |t|
      t.integer :user_id
      t.integer :destination_id
      t.boolean :visited, default: false

      t.timestamps
    end
  end
end
