require 'uri'
require 'net/http'
require 'json'
require 'dotenv/load'

class EasyBrokerAPI
  BASE_URL = URI("https://api.stagingeb.com/v1/")
  API_KEY = ENV['API_KEY']

  def fetch_properties
    url = URI("#{BASE_URL}/properties")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["accept"] = 'application/json'
    request["X-Authorization"] = API_KEY

    response = http.request(request)

    puts "HTTP Status Code: #{response.code}"
    puts "Response Body: #{response.body[0..200]}"

    if response.is_a?(Net::HTTPSuccess)
      begin
        properties = JSON.parse(response.body)['content']
        if properties.nil? || properties.empty?
          puts "No se encontraron propiedades."
        else
          properties.each do |property|
            puts property['title']
          end
        end
      rescue JSON::ParserError => e
        puts "Error al parsear JSON: #{e.message}"
        puts "Respuesta recibida: #{response.body[0..200]}"
      end
    else
      puts "Error: #{response.message}"
    end
  end
end

api = EasyBrokerAPI.new
api.fetch_properties

