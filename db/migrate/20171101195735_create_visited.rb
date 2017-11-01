class CreateVisited < ActiveRecord::Migration[5.0]
  def change
    create_table :visited do |t|
      t.integer :destination_id
      t.integer :user_id
    end
  end
end
