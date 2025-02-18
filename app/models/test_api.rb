require 'faraday'
require 'json'

class TestApi
  def initialize(method, action, params = {}, auth_token = nil)
    @host = "http://127.0.0.1:3000/"
    @headers = { 'Content-Type' => 'application/json', "Cache-Control" => "no-cache" }
    @method = method
    @path = get_path(action)
    @params = params
    @auth_token = auth_token
  end

  def do_request
    connection = Faraday.new(url: @host, headers: @headers) do |faraday|
      faraday.request :url_encoded
      faraday.response :logger
      faraday.adapter Faraday.default_adapter
      faraday.options.timeout = 60
      faraday.options.open_timeout = 60
      faraday.headers['Authorization'] = "Bearer #{@auth_token}" if @auth_token
    end

    begin
      response = case @method.downcase
                 when 'post'
                   connection.post(@path, @params.to_json)
                 when 'put'
                   connection.put(@path, @params.to_json)
                 when 'delete'
                   connection.delete(@path)
                 else
                   connection.get(@path)
                 end

      unless response.success?
        raise "Error en la solicitud: #{response.status} - #{response.body}"
      end

      JSON.parse(response.body)
    rescue Faraday::Error => e
      puts "Error de Faraday: #{e.message}"
      nil
    rescue JSON::ParserError => e
      puts "Error al parsear JSON: #{e.message}"
      nil
    rescue => e
      puts "Error inesperado: #{e.message}"
      nil
    end
  end

  private

  def get_path(action)
    case action
    when 'get_users'
      'api/v1/users'
    else
      raise "ERROR: Ruta no definida para la acción #{action}"
    end
  end
end