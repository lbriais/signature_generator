# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'signature_generator/version'

Gem::Specification.new do |spec|
  spec.name          = 'signature_generator'
  spec.version       = SignatureGenerator::VERSION
  spec.authors       = ['Laurent B.']
  spec.email         = ['lbnetid+gh@gmail.com']

  spec.summary       = %q{Generates an HTML signature to be used in mail UA from template.}
  spec.description   = %q{Generates an HTML signature to be used in mail UA from template with multiple mechanisms for substitution.}
  spec.homepage      = 'https://github.com/lbriais/signature_generator'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rspec'

  spec.add_dependency 'easy_app_helper', '~> 4.2'
  spec.add_dependency 'html_minifier'
end
