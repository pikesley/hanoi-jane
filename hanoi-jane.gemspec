# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hanoi/jane/version'

Gem::Specification.new do |spec|
  spec.name          = 'hanoi-jane'
  spec.version       = Hanoi::Jane::VERSION
  spec.authors       = ['pikesley']
  spec.email         = ['sam.pikesley@gmail.com']

  spec.summary       = %q{Solve the Towers of Hanoi}
  spec.description   = %q{Solve the Towers of Hanoi by counting in base 2 or 3}
  spec.homepage      = 'http://sam.pikesley.org/projects/hanoi-jane/'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(spec)/})
  end
  spec.bindir        = 'bin'
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.1.2'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'coveralls', '~> 0.8'
  spec.add_development_dependency 'guard', '~> 2.14'
  spec.add_development_dependency 'guard-rspec', '~> 4.7'

  spec.add_dependency 'thor', '~> 0.19'
  spec.add_dependency 'httparty', '~> 0.15'
  spec.add_dependency 'wiper'
  spec.add_dependency 'gitpaint'
end
