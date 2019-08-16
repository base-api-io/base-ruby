# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'base/version'

Gem::Specification.new do |spec|
  spec.name          = 'base-api-io'
  spec.version       = Base::VERSION
  spec.authors       = ['Gusztáv Szikszai']
  spec.email         = ['guszti5@hotmail.com']

  spec.summary       = 'Ruby client library for the Base API'
  spec.description   = 'Ruby client library for the Base API'
  spec.homepage      = 'https://www.base-api.io'
  spec.license       = 'MIT'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files that have been added into git.
  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(%r{^(test|spec|features)/})
    end
  end

  spec.require_paths = ['lib']

  spec.add_dependency 'faraday', '~> 0.15.4'

  spec.add_development_dependency 'bundler', '~> 1.17'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.74.0'
  spec.add_development_dependency 'webmock', '~> 3.6'
end
