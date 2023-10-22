json.extract! booking, :id_book, :date, :category, :price, :status
json.url booking_url(booking, format: :json)
