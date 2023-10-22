class Guest < ApplicationRecord
    belongs_to :booking, foreign_key: 'id_book'
    has_one :ticket

    #  Создаём UUID
    before_create :generate_uuid
    private
    def generate_uuid
      self.id = SecureRandom.uuid
    end
  end