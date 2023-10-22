class AddNameToTickets < ActiveRecord::Migration[6.1]
  def change
    add_column :tickets, :name, :string
  end
end
