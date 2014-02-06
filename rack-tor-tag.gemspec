Gem::Specification.new do |s|
  s.name = "rack-tor-tag"
  s.version = `cat #{File.dirname(__FILE__)}/VERSION`
  s.authors = ['Sai', 'Luca Bonmassar']
  s.email = ['sai@makeyourlaws.org']
  s.homepage = 'https://makeyourlaws.org'
  s.summary = 'Mark Tor users using rack, for filtering / throttling / etc'
  s.description = 'Mark Tor users using rack, for filtering / throttling / etc'
  s.files = `git ls-files | grep lib`.split("\n")

  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ["lib"]

  s.add_runtime_dependency "rack", '>= 1.3'
  s.add_development_dependency "rake", '> 0'
end
