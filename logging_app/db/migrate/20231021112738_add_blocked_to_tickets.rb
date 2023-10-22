class AddBlockedToTickets < ActiveRecord::Migration[6.1]
  def change
    add_column :tickets, :blocked, :boolean
  end
end
