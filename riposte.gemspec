# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'riposte/version'

Gem::Specification.new do |spec|
  spec.name          = "riposte"
  spec.version       = Riposte::VERSION
  spec.authors       = ["Amos L King"]
  spec.email         = ["amos.l.king@gmail.com"]
  spec.summary       = %q{A micro-gem for handling different outcomes of an action}
  spec.homepage      = "https://github.com/BinaryNoggin/riposte"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.2.0"
  spec.add_development_dependency "coveralls"
  spec.add_development_dependency "codeclimate-test-reporter"
  spec.add_development_dependency "guard", "~> 2.12.0"
  spec.add_development_dependency "guard-rspec", "~> 4.5.0"
end
