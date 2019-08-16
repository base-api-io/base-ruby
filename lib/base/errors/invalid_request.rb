# frozen_string_literal: true

module Base
  # The error for invalid API requests, which are returned from API in the
  # following JSON format:
  #
  #   {
  #     "error": "TYPE_OF_ERROR",
  #     "data": {
  #       "key": "Additional information."
  #     }
  #   }
  class InvalidRequest < StandardError
    attr_reader :data

    def initialize(data)
      @data = data
    end
  end
end
