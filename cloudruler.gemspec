# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cloudruler/version'

Gem::Specification.new do |spec|
  spec.name          = 'cloudruler'
  spec.version       = Cloudruler::VERSION
  spec.authors       = ['pataiji']
  spec.email         = ['pataiji@gmail.com']

  spec.summary       = 'Management tool for AWS CloudFormation inspired by Itamae'
  spec.description   = 'Management tool for AWS CloudFormation inspired by Itamae'
  spec.homepage      = 'https://github.com/pataiji/cloudruler'
  spec.license       = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
