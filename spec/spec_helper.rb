# frozen_string_literal: true

require 'bundler/setup'
require 'tempfile'
require 'webmock'
require 'base'

WebMock.enable!
WebMock.disable_net_connect!

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = %i[should expect]
  end
end
