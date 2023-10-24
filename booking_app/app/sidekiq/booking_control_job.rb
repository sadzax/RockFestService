# фоновая задача для отмены некупленных броней
class BookingControlJob
  include Sidekiq::Job

  def perform(id)
    book = Booking.find_by(id: id)
    if book.try(:status) == 'booked'
      book.delete
      SiteService.call(**{category: book.category, date: book.date})
    end
  end
end
