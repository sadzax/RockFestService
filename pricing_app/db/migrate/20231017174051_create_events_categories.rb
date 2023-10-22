class CreateEventsCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :events_categories do |t|
      t.references :event, foreign_key: true
      t.string :category
      t.integer :remaining_tickets

      t.timestamps
    end
  end
end
