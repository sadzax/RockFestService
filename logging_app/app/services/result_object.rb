# frozen_string_literal: true

# Вспомогательный класс для отдачи его методами сервисов
class ResultObject
  attr_reader :http_status

  def initialize(result, message, http_status)
    @result = result
    @message = message
    @http_status = http_status
  end

  def data
    { result: @result, message: @message }
  end
end
