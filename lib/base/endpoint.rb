# frozen_string_literal: true

require_relative 'errors/invalid_request'
require_relative 'errors/unauthorized'
require_relative 'errors/unkown_error'

module Base
  # Middleware to raise error on 422 and 401
  class RaiseError < Faraday::Response::Middleware
    def on_complete(env)
      case env[:status]
      when 422
        raise InvalidRequest, JSON.parse(env.body)
      when 401
        raise Unauthorized
      end
    end
  end
end

module Base
  # The base class for an endpoint.
  #
  # It handles request lifecycle and error handling and offers a
  # Faraday::Connection
  class Endpoint
    attr_reader :connection
    attr_reader :path

    # Initializes the endpoint with an access_token and url.
    def initialize(access_token:, url:)
      @connection =
        Faraday.new(
          "#{url}/v1/#{path}/",
          headers: { 'Authorization' => "Bearer #{access_token}" }
        ) do |conn|
          conn.use RaiseError
          conn.use Faraday::Adapter::NetHttp
        end
    end

    # Handles errors that happen in its block.
    def request
      yield
    rescue Unauthorized, InvalidRequest => e
      raise e
    rescue StandardError => e
      raise UnkownError.new(e)
    end

    def parse(body)
      object = JSON.parse(body, object_class: OpenStruct)

      object.created_at = Time.rfc2822(object.created_at) if object.created_at

      object
    end

    def io(body)
      case body
      when IO
        body
      when String
        StringIO.new(body)
      else
        IO.try_convert(body)
      end
    end
  end
end
