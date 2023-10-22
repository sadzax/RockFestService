# frozen_string_literal: true

# Адаптер для связи с сервисом по покупке билетов
class TicketSiteAdapter
  BASE_URL = ENV.fetch('TICKET_URL', nil)

  def initialize
    @client = create_client
  end

  def get_ticket(body_params)
    response = client.request(:get, "#{BASE_URL}/check_ticket", body_params)
    parse_response(response)
  end

  def create_client
    HTTPClient.new
  end

  private

  attr_reader :client

  def parse_response(response)
    JSON.parse(response.body)
  end
end
