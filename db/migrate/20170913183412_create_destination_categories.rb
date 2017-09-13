class CreateDestinationCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :destination_categories do |t|
      t.integer :destination_id
      t.integer :category_id

      t.timestamps
    end
  end
end
