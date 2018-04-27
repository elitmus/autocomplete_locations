$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "autocomplete_locations/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "autocomplete_locations"
  s.version     = AutocompleteLocations::VERSION
  s.authors       = ["Mukarram"]
  s.email         = ["mukarram.ali@elitmus.com"]

  s.summary       = %q{For autocomplete locations.}
  s.description   = %q{For autocomplete locations.}
  s.homepage      = ""


  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 4.2"
  s.add_development_dependency 'factory_bot'

end
