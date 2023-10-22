require 'httpclient'
require 'json'
require 'uri'

class BuyingController < ApplicationController

  skip_before_action :verify_authenticity_token

  def new
    #  Новый заказ формируется через view
  end

  def buy
    #  Получаем данные от пользователя, предполагаем, что оплата уже прошла
    user_input = params.permit(:name, :age, :doc_type, :doc_num, :id_book)

    #  Отправляю патч на '/booking_app'
    client = HTTPClient.new
    response_of_the_service = client.patch("http://localhost:3004/bookings/#{user_input[:id_book]}", json: { status: 'bought' })

    if response_of_the_service.code == 404
      flash[:error] = 'Извините, номер брони не подходит'
      redirect_to root_path
    else
      booking_data = JSON.parse(response_of_the_service.to_s, symbolize_names: true)
      create_guest_and_ticket(booking_data)
      #  Отправляем пользователю "привет с данными билета"
    end
  end

  private

  def create_guest_and_ticket(booking_data)
    guest = Guest.create(
      id_book: booking_data[:id_book],
      name: '...', 
      doc_type: '...',
      doc_num: '...'
    )

    Ticket.create(
      id_guest: guest.id,
      name: guest.name,
      doc_type: guest.doc_type,
      doc_num: guest.doc_num,
      category: booking_data[:category],
      date: booking_data[:date],
      price: booking_data[:price]
    )
  end
end