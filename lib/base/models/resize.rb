# frozen_string_literal: true

module Base
  # Class for the resize data.
  class Resize
    attr_reader :height
    attr_reader :width

    def initialize(width:, height:)
      @height = height
      @width = width
    end

    def to_s
      [@width, @height].join('_')
    end
  end
end
