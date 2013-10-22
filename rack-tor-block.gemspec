Gem::Specification.new do |s|
  s.name = "rack-tor-block"
  s.version = `cat #{File.dirname(__FILE__)}/VERSION`
  s.authors = ['Luca Bonmassar']
  s.email = ['luca@gild.com']
  s.homepage = 'http://www.gild.com'
  s.summary = 'Prevent tor users to access a Rack / Rails application.'
  s.description = 'Identify and prevent tor users to access a Rack / Rails application.'
  s.files = `git ls-files | grep lib`.split("\n")

  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ["lib"]

  s.add_runtime_dependency "rack", '>= 1.3'
  s.add_development_dependency "rake", '> 0'
end
