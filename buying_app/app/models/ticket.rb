class Ticket < ApplicationRecord
    belongs_to :guest, foreign_key: 'id_guest'

    #  Создаём UUID
    before_create :generate_uuid
    private
    def generate_uuid
        self.id = SecureRandom.uuid
    end
end