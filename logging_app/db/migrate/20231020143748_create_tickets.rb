class CreateTickets < ActiveRecord::Migration[6.1]
  def change
    create_table :tickets do |t|
      t.string :id_ticket
      t.string :category
      t.string :doc_type
      t.string :doc_num
      t.datetime :date
      t.string :status

      t.timestamps
    end
  end
end
