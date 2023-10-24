class CreateTickets < ActiveRecord::Migration[6.1]
  def change
    create_table :tickets do |t|
      t.string :id_guest
      t.string :name
      t.integer :age
      t.string :doc_type
      t.string :doc_num
      t.string :category
      t.date :date
      t.integer :price

      t.timestamps
    end
  end
end
