# frozen_string_literal: true

# Класс для блокировки билета
class BlockService
  class DockError < StandardError; end
  class TicketError < StandardError; end
  class ParamsError < StandardError; end

  def initialize(params)
    @params = params
  end

  def call
    check_params
    get_ticket_info
    check_docs
    update_ticket_status
  rescue ParamsError
    ResultObject.new(false, 'Вы не ввели номер билета или номер документа', 400)
  rescue TicketError
    ResultObject.new(false, 'Такого билета не существует', 406)
  rescue SocketError
    ResultObject.new(false, 'Нет доступа к сервису Byuing', 503)
  rescue DockError
    ResultObject.new(false, 'Номер документа неправильный', 406)
  end

  private

  attr_reader :params

  def check_params
    raise ParamsError if params[:id_ticket].nil? || params[:doc_num].nil?
  end

  def get_ticket_info
    @ticket_info = TicketSiteAdapter.new.get_ticket(params[:id_ticket])
    raise TicketError if @ticket_info['result'] == false
  end

  def check_docs
    raise DockError if params[:doc_num] != @ticket_info['doc_num']
  end

  def update_ticket_status
    my_ticket = Ticket.find_by_id_ticket(@ticket_info['id_ticket'])
    if my_ticket.nil?
      Ticket.create(id_ticket: @ticket_info['id_ticket'], blocked: true)
    else
      my_ticket.update(blocked: true)
    end

    ResultObject.new(true, 'Билет успешно заблокирован', 200)
  end
end
