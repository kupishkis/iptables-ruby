# encoding: utf-8
$:.push File.expand_path('../lib', __FILE__)
require 'iptables/version'

Gem::Specification.new do |gem|
  gem.name          = "iptables-ruby"
  gem.version       = IPTables::VERSION
  gem.platform      = Gem::Platform::RUBY
  gem.summary       = "Generate and read iptables rules with Ruby"
  gem.description   = "This here should be a description"
  gem.authors       = ["Kurt Yoder", "Vytis Valentinavičius"]
  gem.email         = ["xytis2000 at gmail com"]
  gem.homepage      = "http://github.com/kupishkis/iptables-ruby"
  gem.license       = "MIT"

  gem.add_dependency "diff-lcs", "~> 1"

  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.require_paths = ['lib']
end
