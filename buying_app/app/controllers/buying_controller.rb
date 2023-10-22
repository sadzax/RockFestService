class BuyingController < ApplicationController
    def buy
      #  Получаем данные от пользователя, предполагаем, что оплата уже прошла
      id_book = '...',
      name: '...',
      doc_type: '...',
      doc_num: '...',
      age = '...'
  
      #  Отправляю патч на '/booking_app'
      response = HTTP.patch("http://localhost:3005/bookings/#{id_book}", json: { status: 'bought' })
  
      if response.code == 404
        flash[:error] = 'Извините, номер брони не подходит'
        redirect_to root_path
      else
        booking_data = JSON.parse(response.to_s, symbolize_names: true)
        create_guest_and_ticket(booking_data)
        #  Redirect or render success message as needed
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