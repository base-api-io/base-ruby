# frozen_string_literal: true

module Base
  # An error when we don't know what happened.
  class UnkownError < StandardError
    attr_reader :error

    def initialize(error)
      @error = error
    end
  end
end
