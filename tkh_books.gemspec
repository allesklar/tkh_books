# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tkh_books/version'

Gem::Specification.new do |spec|
  spec.name          = "tkh_books"
  spec.version       = TkhBooks::VERSION
  spec.authors       = ["Swami Atma"]
  spec.email         = ["swamiatma@yoga108.org"]

  spec.summary       = %q{A Rails engine to create the resources necessary to create an online, HTML book.}
  spec.description   = %q{This Rails engine can easily integrate with the tkh_cms gem suite and allows the user to create online, HTML books.}
  spec.homepage      = "https://github.com/allesklar/tkh_books"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
end
