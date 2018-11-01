$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "twitch_engine/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "twitch_engine"
  s.version     = TwitchEngine::VERSION
  s.authors     = ["Hunter Pollpeter"]
  s.email       = ["hunter@rocketreferrals.com"]
  s.homepage    = ""
  s.summary     = ""
  s.description = ""
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.2.1"
end
