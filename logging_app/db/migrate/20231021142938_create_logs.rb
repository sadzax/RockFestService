class CreateLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :logs do |t|
      t.integer :id_ticket
      t.datetime :date
      t.string :name
      t.string :operation_type
      t.boolean :result

      t.timestamps
    end
  end
end
