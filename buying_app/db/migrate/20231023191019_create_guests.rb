class CreateGuests < ActiveRecord::Migration[6.1]
  def change
    create_table :guests do |t|
      t.string :id_book
      t.string :name
      t.integer :age
      t.string :doc_type
      t.string :doc_num

      t.timestamps
    end
  end
end
