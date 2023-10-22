class Guest < ApplicationRecord
    belongs_to :booking, foreign_key: 'id_book'
    has_one :ticket
  end