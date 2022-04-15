# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'spring/version'

Gem::Specification.new do |spec|
  spec.name          = 'springWeb'
  spec.version       = Spring::VERSION
  spec.authors       = ['Krisna Pranav']
  spec.email         = ['krisna.pranav@gmail.com']

  spec.summary       = 'Spring Is A Web Framework Built Using Ruby'
  spec.description   = 'Spring Is A Web Framework Built Using Ruby'
  spec.homepage      = 'https://github.com/krishpranav/spring'
  spec.license       = 'MIT'

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  else
    raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'iodine', '>= 0.6.0', '< 0.8.0'
  spec.add_dependency 'rack', '>= 2.0.0'

  spec.add_development_dependency 'rake', '~> 12.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
end