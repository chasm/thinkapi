# -*- encoding: utf-8 -*-
# stub: sinatra-advanced-routes 0.5.3 ruby lib

Gem::Specification.new do |s|
  s.name = "sinatra-advanced-routes"
  s.version = "0.5.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Konstantin Haase", "Jean-Philippe Doyle"]
  s.date = "2013-04-19"
  s.description = "Make Sinatra routes first class objects."
  s.email = "konstantin.mailinglists@googlemail.com"
  s.homepage = "http://github.com/rkh/sinatra-advanced-routes"
  s.rubygems_version = "2.2.2"
  s.summary = "Make Sinatra routes first class objects."

  s.installed_by_version = "2.2.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<sinatra>, ["~> 1.0"])
      s.add_development_dependency(%q<rspec>, [">= 1.3.0"])
      s.add_development_dependency(%q<rack-test>, [">= 0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<sinatra-contrib>, [">= 0"])
    else
      s.add_dependency(%q<sinatra>, ["~> 1.0"])
      s.add_dependency(%q<rspec>, [">= 1.3.0"])
      s.add_dependency(%q<rack-test>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<sinatra-contrib>, [">= 0"])
    end
  else
    s.add_dependency(%q<sinatra>, ["~> 1.0"])
    s.add_dependency(%q<rspec>, [">= 1.3.0"])
    s.add_dependency(%q<rack-test>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<sinatra-contrib>, [">= 0"])
  end
end
