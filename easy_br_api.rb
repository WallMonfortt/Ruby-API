require 'uri'
require 'net/http'
require 'json'


class EasyBrokerAPI
  BASE_URL = URI("https://api.stagingeb.com/v1/")
  API_KEY = 'l7u502p8v46ba3ppgvj5y2aad50lb9'

  def fetch_properties
    url = URI("#{BASE_URL}/properties")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["accept"] = 'application/json'
    request["X-Authorization"] = 'l7u502p8v46ba3ppgvj5y2aad50lb9'

    response = http.request(request)
    puts response.read_body

    if response.is_a?(Net::HTTPSuccess)
      begin
        properties = JSON.parse(response.body)['content']
        properties.each do |property|
          puts property['title']
        end
      rescue JSON::ParserError => e
        puts "Error al parsear JSON: #{e.message}"
        puts "Respuesta recibida: #{response.body[0..200]}"  # Muestra los primeros 200 caracteres
      end
    else
      puts "Error: #{response.message}"
    end
  end
end
