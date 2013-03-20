# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'SimpleHTTPServer/version'

Gem::Specification.new do |gem|
  gem.name          = "SimpleHTTPServer"
  gem.version       = SimpleHTTPServer::VERSION
  gem.authors       = ["Usman Bashir"]
  gem.email         = ["me@usmanbashir.com"]
  gem.description   = %q{A Ruby based Simple HTTP Server that's not so simple after all.}
  gem.summary       = gem.description
  gem.homepage      = "https://github.com/usmanbashir/SimpleHTTPServer"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
