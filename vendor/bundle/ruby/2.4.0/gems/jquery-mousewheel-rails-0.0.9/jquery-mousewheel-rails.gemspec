# Maintain your gem's version:
require File.expand_path("../lib/jquery-mousewheel-rails/version", __FILE__)

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "jquery-mousewheel-rails"
  s.version     = JqueryMousewheelRails::VERSION
  s.authors     = ["Mike MacDonald"]
  s.email       = ["crazymykl@gmail.com"]
  s.homepage    = "https://github.com/crazymykl/jquery-mousewheel-rails"
  s.summary     = "Integrates jquery-mousewheel with rails."
  s.description = ""

  s.files         = `git ls-files`.split($/)
  s.executables   = s.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]
  s.license       = 'MIT'

  s.add_runtime_dependency 'railties', '>= 3.1'
  s.add_development_dependency "sqlite3"
end
