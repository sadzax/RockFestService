class Guest < ApplicationRecord
    belongs_to :booking, foreign_key: 'id_book'
    has_one :ticket

    attribute :id, :string
    attribute :id_book, :string
    attribute :name, :string
    attribute :age, :integer
    attribute :doc_type, :string
    attribute :doc_num, :string

    #  Создаём UUID
    after_create :generate_uuid
    private
    def generate_uuid
      self.id = SecureRandom.uuid
    end
end