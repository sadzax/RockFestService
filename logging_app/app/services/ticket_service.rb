# frozen_string_literal: true

# Класс для обработки входа и выхода посетителей
class TicketService
  class BlockedError < StandardError; end
  class CategoryError < StandardError; end
  class DateError < StandardError; end
  class TypeError < StandardError; end
  class TicketError < StandardError; end
  class ParamsError < StandardError; end

  def initialize(params, type)
    @type = type
    @params = params
  end

  def call
    check_params
    get_ticket_info
    check_blocked
    check_type
    check_date
    check_category
    update_ticket
  rescue ParamsError
    ResultObject.new(false, 'Вы не ввели номер билета или категорию', 400)
  rescue TicketError
    ResultObject.new(false, 'Такого билета не существует', 406)
  rescue BlockedError
    CreateLog.new(@ticket_info['id_ticket'], @ticket_info['name'], @type, false).call
    ResultObject.new(false, 'Билет заблокирован', 406)
  rescue TypeError
    CreateLog.new(@ticket_info['id_ticket'], @ticket_info['name'], @type, false).call
    ResultObject.new(false, 'Невозможно выйти/войти два раза подряд', 406)
  rescue CategoryError
    CreateLog.new(@ticket_info['id_ticket'], @ticket_info['name'], @type, false).call
    ResultObject.new(false, 'У вас билет другой категории', 406)
  rescue DateError
    CreateLog.new(@ticket_info['id_ticket'], @ticket_info['name'], @type, false).call
    ResultObject.new(false, 'Ваш билет на другой день', 406)
  rescue SocketError
    ResultObject.new(false, 'Нет связи с сервисом byuing', 503)
  end

  private

  attr_reader :params

  def check_params
    raise ParamsError if params[:id_ticket].nil? || params[:category].nil?
  end

  def get_ticket_info
    @ticket_info = TicketSiteAdapter.new.get_ticket(params[:id_ticket])
    @my_ticket = Ticket.find_by_id_ticket(@ticket_info['id_ticket'])
    raise TicketError if @ticket_info['result'] == false
  end

  def check_type
    return if @my_ticket.nil?
    raise TypeError if @type == 'enter' && @my_ticket[:status] == 'in'
    raise TypeError if @type == 'exit' && @my_ticket[:status] == 'out'
  end

  def get_status
    if @my_ticket.nil?
      status = 'in'
    elsif @my_ticket.status == 'out'
      status = 'in'
    elsif @my_ticket.status == 'in'
      status = 'out'
    end
    status
  end

  def check_blocked
    return if @my_ticket.nil?
    raise BlockedError if @my_ticket.blocked == true
  end

  def check_date
    raise DateError if @ticket_info['date'] != Date.today.to_s
  end

  def check_category
    raise CategoryError if @ticket_info['category'] != params[:category]
  end

  def update_ticket
    status = get_status
    if @my_ticket.nil?
      Ticket.create(id_ticket: @ticket_info['id_ticket'],
                    category: @ticket_info['category'],
                    doc_type: @ticket_info['doc_type'],
                    doc_num: @ticket_info['doc_num'],
                    date: @ticket_info['date'],
                    status: status,
                    name: @ticket_info['name'],
                    blocked: false)
    else
      @my_ticket.update(id_ticket: @ticket_info['id_ticket'],
                        category: @ticket_info['category'],
                        doc_type: @ticket_info['doc_type'],
                        doc_num: @ticket_info['doc_num'],
                        date: @ticket_info['date'],
                        status: status,
                        name: @ticket_info['name'],
                        blocked: false)
    end

    CreateLog.new(@ticket_info['id_ticket'], @ticket_info['name'], @type, true).call
    ResultObject.new(true, 'Вы прошли через турникет', 200)
  end
end
