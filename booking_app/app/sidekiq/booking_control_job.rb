# фоновая задача для отмены некупленных броней
class BookingControlJob
  include Sidekiq::Job

  def perform(id)
    book = Booking.find_by(id: id)
    if book.try(:status) == 'booked'
      SiteService.call(**{category: book.category, date: book.date})
      book.delete
    end
  end
end
