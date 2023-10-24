class Ticket < ApplicationRecord
    belongs_to :guest, foreign_key: 'id_guest'

    attribute :id, :string
    attribute :id_guest, :string
    attribute :name, :string
    attribute :age, :integer
    attribute :doc_type, :string
    attribute :doc_num, :string
    attribute :category, :string
    attribute :date, :datetime
    attribute :price, :integer

    #  Создаём UUID
    after_create :generate_uuid
    private
    def generate_uuid
      self.id = SecureRandom.uuid
    end
end