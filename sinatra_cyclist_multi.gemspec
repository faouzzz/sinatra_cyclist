# -*- encoding: utf-8 -*-
require File.expand_path('../lib/sinatra/cyclist/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Michael Lavrisha", 'Nabil Abachouayb']
  gem.email         = ["michael.lavrisha@gmail.com", 'me@nabile.fr']
  gem.description   = %q{Cycle through pages at a regular interval}
  gem.summary       = %q{Sinatra can ride a bicycle over and over and over again}
  gem.homepage      = "https://github.com/faouzzz/sinatra_cyclist_multi"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "sinatra_cyclist_multi"
  gem.require_paths = ["lib"]
  gem.version       = Sinatra::Cyclist::VERSION

  gem.add_dependency "sinatra"

end
