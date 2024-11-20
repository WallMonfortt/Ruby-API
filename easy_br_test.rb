require 'minitest/autorun'
require_relative 'easy_br_api'

class EasyBrokerAPITest < Minitest::Test
  def setup
    @api = EasyBrokerAPI.new
  end

  def test_fetch_properties
    expected_titles = [
      "Casa bien bonita",
      "Bodega en Naucalpan",
      "Casa en Renta en Residencial Privada Jardín, Juárez, N.L."
    ]

    begin
      assert_output(/#{expected_titles.join('|')}/) do
        @api.fetch_properties
      end
      puts "Test 'test_fetch_properties' passed."
    rescue Minitest::Assertion => e
      puts "Test 'test_fetch_properties' failed: #{e.message}"
      raise
    end
  end
end
