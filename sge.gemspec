# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "sge/version"

Gem::Specification.new do |s|
  s.name        = "sge"
  s.version     = SGE::VERSION
  s.authors     = ["Hallelujah"]
  s.email       = ["hery@rails-royce.org"]
  s.homepage    = ""
  s.summary     = %q{Sun Grid Engine ruby library}
  s.description = %q{Sun Grid Engine ruby library}

  s.rubyforge_project = "sge"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  if RUBY_VERSION >= '1.8.6'
    s.add_runtime_dependency "nokogiri"
  else
    s.add_runtime_dependency "nokogiri", "< 1.5.0"
  end
  s.add_development_dependency "rspec"
  s.add_development_dependency "rake"

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
