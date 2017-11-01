class CreateNotes < ActiveRecord::Migration[5.0]
  def change
    create_table :notes do |t|
      t.integer :destination_id
      t.integer :user_id
      t.text :content
    end
  end
end
