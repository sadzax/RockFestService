class Ticket < ApplicationRecord
    belongs_to :guest, foreign_key: 'id_guest'
end