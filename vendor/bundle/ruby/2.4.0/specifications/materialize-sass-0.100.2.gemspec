# -*- encoding: utf-8 -*-
# stub: materialize-sass 0.100.2 ruby lib

Gem::Specification.new do |s|
  s.name = "materialize-sass".freeze
  s.version = "0.100.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["mkhairi".freeze]
  s.date = "2017-08-30"
  s.description = "Use materialzecss in your rails asset pipeline.".freeze
  s.email = ["khairi@labs.my".freeze]
  s.homepage = "https://github.com/mkhairi/materialize-sass".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.6.14".freeze
  s.summary = "Materialzecss sass for rails.".freeze

  s.installed_by_version = "2.6.14" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.7"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 10.0"])
      s.add_runtime_dependency(%q<sass>.freeze, ["~> 3.3"])
    else
      s.add_dependency(%q<bundler>.freeze, ["~> 1.7"])
      s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
      s.add_dependency(%q<sass>.freeze, ["~> 3.3"])
    end
  else
    s.add_dependency(%q<bundler>.freeze, ["~> 1.7"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
    s.add_dependency(%q<sass>.freeze, ["~> 3.3"])
  end
end
