require 'net/http'
require 'uri'
require 'json'
# сообщает pricing о новой брони и ждет в ответ стоимость
class PriceService
  def self.call(params)
    date = []
    3.times{|i| date.push(params["date(#{i+1}i)"])} 
    date = date.join('-')
    date ||= params[:date]
    uri = URI("http://pricing_app:3003/events/#{date}/#{params[:category]}")
    response = Net::HTTP.get_response(uri)
    status = response.code.to_i
    response = JSON.parse(response.body)
    price = response['result']
    {status: status, price: price}
  end
end
