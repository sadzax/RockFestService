# frozen_string_literal: true

# Контроллер для входа/выхода и блокировки
class TicketsController < ApplicationController
  def enter
    result = TicketService.new(params, 'enter').call
    render json: JSON.generate(result.data), status: result.http_status
  end

  def exit
    result = TicketService.new(params, 'exit').call
    render json: JSON.generate(result.data), status: result.http_status
  end

  def block
    result = BlockService.new(params).call
    render json: JSON.generate(result.data), status: result.http_status
  end
end
