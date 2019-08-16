# frozen_string_literal: true

module Base
  # Class for the crop data.
  class Crop
    attr_reader :height
    attr_reader :width
    attr_reader :left
    attr_reader :top

    def initialize(width:, height:, left:, top:)
      @height = height
      @width = width
      @left = left
      @top = top
    end

    def to_s
      [@width, @height, @left, @top].join('_')
    end
  end
end
