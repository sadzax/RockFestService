class EventsController < ApplicationController
  skip_before_action :verify_authenticity_token
  BASIC_STANDARD_PRICE = 1000
  BASIC_VIP_PRICE = 2000
  @@current_standars_price = BASIC_STANDARD_PRICE
  @@current_vip_price = BASIC_VIP_PRICE
  def tickets_count
    event_date = params[:date]
    category = params[:category]


    event = Event.find_by(date: event_date)
    if event
      category_record = event.events_categories.find_by(category: category)

      if category_record
        base_price = category_record.category == 'vip' ? @@current_vip_price : @@current_standars_price
        remaining_tickets = category_record.remaining_tickets

        if remaining_tickets > 0
          category_record.update(remaining_tickets: remaining_tickets - 1)
        else
          render json: {error: 'No tickets'}
          return
        end
        max_available_tickets = category == 'vip' ? 50 : 150
        available_tickets = category_record.remaining_tickets
        ten_percent_tickets = max_available_tickets / 10

        if available_tickets % ten_percent_tickets == 0
          base_price += (base_price * 0.1).to_i
        end
        category_record.category == 'vip' ? @@current_vip_price = base_price : @@current_standars_price = base_price
        render json: {result: base_price, tickets: category_record.remaining_tickets}
      else
        render json: { result: 'Category not found for the specified date' }, status: :not_found
      end
    else
      render json: { error: 'Event not found for the specified date' }, status: :not_found
    end
  end

  def increase_tickets
    event_date = params[:date]
    category = params[:category]

    event = Event.find_by(date: event_date)
    if event
      category_record = event.events_categories.find_by(category: category)
      max_available_tickets = category == 'vip' ? 50 : 150

      if category_record
        remaining_tickets = category_record.remaining_tickets

        if remaining_tickets < max_available_tickets
          category_record.update(remaining_tickets: remaining_tickets + 1)
          render json: { result: 'success', tickets: category_record.remaining_tickets }
        else
          render json: { error: 'All tickets are already sold out' }, status: :unprocessable_entity
        end
      else
        render json: { error: 'Category not found for the specified date' }, status: :not_found
      end
    else
      render json: { error: 'Event not found for the specified date' }, status: :not_found
    end
  end
end
