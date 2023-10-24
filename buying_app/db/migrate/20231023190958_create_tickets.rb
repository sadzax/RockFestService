class CreateTickets < ActiveRecord::Migration[6.1]
  def change
    create_table :tickets do |t|
      t.string :name
      t.integer :age
      t.string :doc_type
      t.string :doc_num

      t.timestamps
    end
  end
end
