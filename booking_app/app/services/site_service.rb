require 'net/http'
require 'uri'
require 'json'
# сообщает pricing об отмене брони
class SiteService
  def self.call(date:, category:)
    uri = URI.parse("http://pricing_app:3003/events/#{date}/#{category}")
    request = Net::HTTP::Patch.new(uri)
    response = Net::HTTP.start(uri.hostname, uri.port).request(request)
  end
end