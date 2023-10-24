
class BookingsController < ApplicationController
  # нельзя не скипать данную проверку
  skip_before_action :verify_authenticity_token
  before_action :set_booking, only: %i[ show edit update destroy ]

  def show
    unless Booking.find_by(id_book: params[:id])
      render plain: "Бронирование не найдено", status: :not_found
    end
  end

  def new
    @booking = Booking.new
  end

  def create
    id_book = SecureRandom.uuid
    status = 'booked'
    price = PriceService.call(booking_params)
    if price[:status] == 200 && %w[fan vip].include?(booking_params[:category])
      @booking = Booking.create(booking_params)
      @booking.update(id_book: id_book, status: status, price: price[:price])
      respond_to do |format|
        format.html { redirect_to "/bookings/#{@booking.id_book}", 
        notice: "Успешное бронирование. Время действия бронирования 5 минут." }
        format.json { render :show, status: :created, location: @booking }
      end
      BookingControlJob.perform_at(@booking.updated_at + 5 * 60, @booking.id)
    else
      redirect_to bookings_url, notice: "Невозможно забронировать билет с указанными параметрами"
    end
  end

  def update
    if @booking.try(:update, booking_params)
      render json: { id_book: @booking.id_book, category: @booking.category, date: @booking.date,
                     price: @booking.price, status: @booking.status }, status: :ok
    else
      render json: {result: false}, status: :not_found
    end
  end

  def destroy
    begin
      if @booking.status == 'booked'
        @booking.destroy
        SiteService.call({category: @booking.category, date: @booking.date})
        respond_to do |format|
          format.html { redirect_to bookings_url, notice: "Бронирование отменено" }
          format.json { head :no_content }
        end
      else
        render plain: "Билет уже куплен, деньги потрачены. Приходите (пожалуйста)"
      end
    rescue NoMethodError
      render json: {result: false}, status: :not_found
    end
  end

  private

  def set_booking
    @booking = Booking.find_by(id_book: params[:id])
  end

  def booking_params
    params.require(:booking).permit(:date, :category, :status)
  end
end
