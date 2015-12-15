# -*- encoding: utf-8 -*-
# stub: base62 1.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "base62"
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["JT Zemp", "Lasse Bunk", "Saadiq Rodgers-King", "Derrick Camerino"]
  s.date = "2014-01-16"
  s.description = "Base62 monkeypatches Integer to add an Integer#base62_encode\n                       instance method to encode an integer in the character set of\n                       0-9 + A-Z + a-z. It also monkeypatches String to add\n                       String#base62_decode to take the string and turn it back\n                       into a valid integer."
  s.email = ["jtzemp@gmail.com", "lasse@bunk.io"]
  s.homepage = "https://github.com/jtzemp/base62"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.5.1"
  s.summary = "Monkeypatches Integer and String to allow for base62 encoding and decoding."

  s.installed_by_version = "2.4.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>, ["~> 1.3"])
      s.add_development_dependency(%q<rake>, [">= 0"])
    else
      s.add_dependency(%q<bundler>, ["~> 1.3"])
      s.add_dependency(%q<rake>, [">= 0"])
    end
  else
    s.add_dependency(%q<bundler>, ["~> 1.3"])
    s.add_dependency(%q<rake>, [">= 0"])
  end
end
