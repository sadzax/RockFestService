class CreateGuests < ActiveRecord::Migration[6.1]
  def change
    create_table :guests do |t|
      t.string :name
      t.integer :age
      t.string :doc_type
      t.string :doc_num
      t.string :category
      t.datetime :date
      t.integer :price

      t.timestamps
    end
  end
end
