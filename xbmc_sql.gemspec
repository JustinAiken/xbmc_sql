$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "xbmc_sql/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "xbmc-sql"
  s.version     = XbmcSql::VERSION
  s.authors     = ["JustinAiken"]
  s.email       = ["60tonangel@gmail.com"]
  s.homepage    = "https://www.github.com/JustinAiken/xbmc-sql"
  s.summary     = "ActiveRecord models for the XBMC database"
  s.description = "ActiveRecord models for the XBMC database"
  s.license     = "MIT"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ['lib']

  s.add_dependency 'rails', '~> 4.0'
  s.add_dependency 'httparty'
  s.add_dependency 'xml-simple'

  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'mysql2'

  s.add_development_dependency 'rspec-rails',        '~> 2.14.2'
  s.add_development_dependency 'factory_girl_rails', '~> 4.0'
  s.add_development_dependency 'guard-rspec',        '~> 4.2.10'
  s.add_development_dependency 'shoulda-matchers'
  s.add_development_dependency %q<coveralls>, ['>= 0']

end
