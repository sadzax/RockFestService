require 'httpclient'
require 'json'
require 'uri'
require 'date'

class BuyingController < ApplicationController
  DEFAULT_URL_FOR_BOOKING = "http://booking_app:3004/"

  skip_before_action :verify_authenticity_token

  def new
    #  Новый заказ формируется через view
  end

  def buy
    #  Получаем данные от пользователя, предполагаем, что оплата уже прошла
    user_input = params.permit(:name, :age, :doc_type, :doc_num, :id_book)
    id_book = user_input[:id_book]

    #  Отправляю патч на '/booking_app'
    client = HTTPClient.new
    headers = { 'Content-Type' => 'application/json' }
    response_of_the_service = client.patch("http://booking_app:3004/bookings/#{id_book}", body: { status: 'bought' }.to_json, header: headers)


    if response_of_the_service.code == 404
      render json: { result: false, error: 'Извините номер брони не подходит' }, status: :not_found
    else
      booking_data = JSON.parse(response_of_the_service.body, symbolize_names: true)
      #  Конвертируем booking_data[:date].class => Date
      if booking_data[:date].class == String
        booking_data[:date] = Date.parse(booking_data[:date])
      end
      create_guest_and_ticket(booking_data, user_input)
      #  Отправляем пользователю "привет с данными билета"
    end
  end

  def check_ticket
    #  Получаю билет
    id_ticket = params[:id_ticket]

    #  Проверяю билет в БД
    if Ticket.find_by(id: id_ticket) == nil
      render json: { result: false, error: 'Билет не найден' }, status: :not_found
      
    else
      #  Беру билет
      ticket = Ticket.find_by(id: id_ticket)
      #  Отдаю JSON
      render json: {result: true,
        id_ticket: ticket.id,
        name: ticket.name,
        category: ticket.category,
        doc_type: ticket.doc_type,
        doc_num: ticket.doc_num,
        # date: ticket.date.strftime('%Y-%m-%d')}  # Отдаст как стринг
        date: ticket.date}
    end
  end

  private

  def create_guest_and_ticket(booking_data, user_input)
    guest = Guest.create(id_book: booking_data[:id_book],
      name: user_input[:name], 
      doc_type: user_input[:doc_type],
      doc_num: user_input[:doc_num])

    Ticket.create(id_guest: guest.id,
      name: guest.name,
      doc_type: guest.doc_type,
      doc_num: guest.doc_num,
      category: booking_data[:category],
      date: booking_data[:date],
      price: booking_data[:price])
  end
end