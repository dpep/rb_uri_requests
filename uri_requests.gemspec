require_relative 'lib/uri_requests'

Gem::Specification.new do |s|
  s.name        = 'uri_requests'
  s.version     = UriRequests::VERSION
  s.authors     = ['Daniel Pepper']
  s.summary     = 'UriRequests'
  s.description = 'URI::HTTP requests made easier'
  s.homepage    = 'https://github.com/dpep/rb_uri_requests'
  s.license     = 'MIT'

  s.files       = Dir.glob('lib/**/*')
  s.test_files  = Dir.glob('test/**/test_*')

  s.add_development_dependency 'rake', '~> 10'
  s.add_development_dependency 'minitest', '~> 5'
  s.add_development_dependency 'debug'
  s.add_development_dependency 'awesome_print', '~> 1'
end
