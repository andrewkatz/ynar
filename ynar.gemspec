# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ynar/version'

Gem::Specification.new do |spec|
  spec.name          = 'ynar'
  spec.version       = Ynar::VERSION
  spec.authors       = ['Andrew Katz']
  spec.email         = ['andrewkatz00@gmail.com']

  spec.summary       = 'You Need a Reconciler'
  spec.description   = 'Reconciliation tool for YNAB'
  spec.homepage      = 'https://github.com/andrewkatz/ynar'
  spec.license       = 'MIT'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.1'
  spec.add_development_dependency 'rake', '>= 12.3.3'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rspec-its', '~> 1.3'
  spec.add_development_dependency 'sinatra', '~> 2.2.0'
  spec.add_development_dependency 'webmock', '~> 3.8'

  spec.add_runtime_dependency 'faraday', '~> 1.0'
  spec.add_runtime_dependency 'money', '~> 6.13'
  spec.add_runtime_dependency 'pry', '~> 0.12'
  spec.add_runtime_dependency 'tty-prompt', '~> 0.20'
  spec.add_runtime_dependency 'tty-spinner', '~> 0.9'
end
