# frozen_string_literal: true

# Класс для создания логов
class CreateLog
  def initialize(id_ticket, name, operation_type, result)
    @id_ticket = id_ticket
    @name = name
    @result = result
    @operation_type = operation_type
  end

  def call
    create_log
  end

  private

  def create_log
    Log.create(id_ticket: @id_ticket,
               date: Time.now, name: @name,
               operation_type: @operation_type,
               result: @result)
  end
end
