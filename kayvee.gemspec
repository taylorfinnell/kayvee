# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kayvee/version'

Gem::Specification.new do |spec|
  spec.name          = 'kayvee'
  spec.version       = Kayvee::VERSION
  spec.authors       = ['Taylor Finnell']
  spec.email         = ['tmfinnell@gmail.com']
  spec.summary       = %q{Key value library with numerous backing implementations.}
  spec.description   = %q{Key value library with numerous backing implementations.}
  spec.homepage      = "http://github.com/taylorfinnell"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib', 'lib/ext']


  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'dotenv'
  spec.add_development_dependency 'fakeredis'

  spec.add_development_dependency 's3'
  spec.add_development_dependency 'redis'
end
