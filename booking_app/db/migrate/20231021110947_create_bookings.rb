class CreateBookings < ActiveRecord::Migration[6.1]
  def change
    create_table :bookings do |t|
      t.string :id_book
      t.date :date
      t.string :category
      t.integer :price
      t.string :status

      t.timestamps
    end
  end
end
